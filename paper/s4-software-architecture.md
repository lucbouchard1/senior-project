
# Software Architecture

As mentioned previously, the ADC software developed for the original ExoCube was not rigorously tested and was not designed to be reused on future PolySat missions. This work set out to architect the ADC software in such a way that it was easy to reuse and extend on future missions, compatible with the larger PolySat code base, and testable in the most flight-like configuration possible. Although the control algorithm for ExoCube 2 is beyond the scope of this paper, its place in the software architecture is discussed for the sake of completeness.

Although high-level languages and environments like MATLAB, Simulink, and Python provide robust ecosystems for developing and validating ADC algorithms, PolySat spacecraft are barred from flying these tools due to the highly resource constrained PolySat flight computer. For this reason, the ADC software was written in C to minimize memory footprint and maximize computational efficiency. This choice had the added benefit of being compatible with the wider PolySat code base [@greg].

## Reusability and Extensibility

Reusability and extensibility were achieved by implementing a basic model of object orientation in C [@ooc]. More specifically, we defined several generic interfaces that together accomplish all the features of the ADC software. A high-level diagram of some these interfaces and their interactions is shown in figure \ref{arch}. Each block represents a different interface. In this UML-style diagram, the arrows do not represent inheritance, but rather reflect the dependency hierarchy within the software. In other words, `ADCS State` stores instances of `Mission Determination` and `Mission Controller`, `Mission Controller` contains multiple `Controller` objects, etc. Because these blocks represent interfaces, different implementations can be easily swapped in and out, enabling ADC developers to reuse past implementations and provide new implementations with little trouble. A configuration file based plugin system was developed to simplify this implementation swapping. Note that the software utilizes many more generic interfaces than depicted, but they were left out of the diagram to reduce clutter.

The two branches depicted in the diagram represent the two primary components of the software, determination and then control. The yellow arrows at the bottom represent the flow of data within the software--the attitude estimate created by the determination side is passed to the control side, and the control torques generated by the control side are passed back to the determination side to be used in the predict step of the Kalman filter.

![Object model for the ADC software architecture.\label{arch}](paper/img/arch.pdf){ width=60% }

### Control Architecture

To create a complete picture of the software architecture, all of the interfaces will be described from the bottom of the diagram upward, starting on the control side. The lowest level interface is the `Actuator`. This is a lightweight API on top of the drivers for actuator hardware like magnetorquers and reaction wheels. Users can pass torque or magnetic dipole moment vectors to these objects and expect the appropriate physical action to take place. Note the the `Actuator` interface actually refers to a set of interfaces, as the API to generically control reaction wheels is fundamentally different from that of a magnetorquer.

Next we move to the `Controller` interface, which utilizes the `Actuator` interfaces to control the attitude or angular velocities of the spacecraft. The `Mission Controller` object passes the `Controller` an attitude estimate, relevant sensor readings, other data that could be useful within a control law, and potentially a desired orientation or angular velocity for the spacecraft. The `Controller` object is where the actual control law is implemented. For example, there is an implementation of a `BDOT Controller`, which torques the magnetorquers in the direction opposite that of the change in magnetic field to slow down the spacecraft's angular velocity. One could also imagine implementing a `Reaction Wheel Controller`, which utilizes reaction wheels and some control law to torque the spacecraft into a desired orientation. The torques and dipole moments generated by the the `Controller` is passed back to the determination branch so that they can be included in the Kalman filter predict step.

The `Mission Controller` is responsible for switching between different `Controller`'s as dictated by the mission requirements. For example, if a spacecraft first needs to detumble using BDOT before starting it's primary control law, the `Mission Controller` would run the `BDOT Controller` until some convergence criteria was met, and then initialize the primary control law. The `Controller`'s themselves are thus agnostic to these mission-specific mode changes.

The larger ADC code base is responsible for calling methods within the `Mission Controller` at the appropriate time. The `Controller` and further the `Mission Controller` are expected to return the amount of time that should elapse before being called again. The allows the `Controller` to vary its time interval. For example, within the `BDOT Controller`, the algorithm samples the magnetometers twice to compute the change in magnetic field, and then proceeds to torque the magnetorquers in the appropriate manner. The time interval between magnetometer samples may be different than the torque duration, thus the `BDOT Controller` needs to vary the time between calls. The `Controller` also returns a flag indicating whether the determination algorithm should be run or not. This temporary suspension of the determination algorithm has many uses. For example, in magnetorquer-dependent `Controller`'s like the `BDOT Controller`, the determination algorithm should not be run while the magnetorquers saturate the magnetometers.

### Determination Architecture

The lowest level of the determination branch is the `Magnetic Model` and `Sun Model`. These are interfaces that take the spacecraft's position and the current time and produce ECI magnetic and solar reference vectors respectively. These are needed by the `Filter` class, which is where the Kalman filter algorithm described above resides, to perform the update step. Wrapping solar and magnetic models in a generic interface allows ADC developers to utilize the reference model that best satisfies the mission requirements.

Implementations of the `Filter` interface are passed sensor readings and control torques and are expected to produce an attitude estimate. The `Mission Filter` adds an extra degree of mission-specific flexibility on top of the `Filter` by allowing missions to switch between `Filter` implementations if needed. Furthermore, if the mission needs to model disturbance torques that aren't modeled in generic `Filter` implementations, the `Filter` interface provides and API to allow `Mission Determination` implementations to provide these contributions to the dynamics.

As mentioned previously, the determination code is executed at the command of the control algorithm. It has no means to change the rate at which it is called.

### Configuration Files

This software utilizes a robust network of configuration files to allow specifying which `Filter`, `Controller`, `Actuator`, etc. implementations to use, thus building out a basic plugin or extension system. As this code base matures, and more robust `Filter` and `Controller` algorithms are prototyped and tested, mission developers will be able to support full attitude determination and control by writing just a series of configuration files and bare-bones implementations of the `Mission Determination` and `Mission Controller` interfaces, which should be similar to example implementations. This enables developers to maximize code reuse and implement only the ADC functionality that is specific to the mission, minimizing risk and development time.

## Testing and Verification