
# Results

Once the Kalman filter was implemented and debugged, and the testing infrastructure described previously was functional, the determination algorithm was tested in a multitude of scenarios to characterize it's performance. The orbit with which it was tested was chosen to be similar to what ExoCube 2 will experience on flight--roughly circular with a $99^\circ$ inclination and an altitude of approximately 500 km.

## Magnetometer and Solar Angle Sensor Determination

We first evaluate the performance of the filter when both of the magnetometer and solar angle measurement are available. To most effectively test the filter's ability, the spacecraft state vector was initialized to a random orientation and a random angular velocity vector of magnitude less than $6\ \frac{deg}{sec}$, which is consistent with CubeSat deployment angular velocity estimates [@sellers]. Gaussian noise was added to the simulated sensor readings, with $5^\circ$ standard deviation added to the magnetometer measurements and $3^\circ$ standard deviation added to the solar angle measurements. These uncertainty values are consistent with the instrumentation on ExoCube 2. Figure \ref{converge1} shows convergence of the filter for seven different trials, where the error angle is defined as the angle between the z-axis of the actual and estimated body frames. The Kalman filter parameters used in these simulations are shown in Table \ref{params1}.

+------------------------------------------+--------------------+
| Process Noise Matrix Diagonal ($Q$)      | $5 \times 10^{-8}$ |
+------------------------------------------+--------------------+
| Initial Covariance Matrix Diagonal ($P$) | $5 \times 10^{-6}$ |
+------------------------------------------+--------------------+
| Magnetic Field Measurement Noise ($R$)   | $0.5$              |
+------------------------------------------+--------------------+
| Solar Angle Measurement Noise ($R$)      | $0.4$              |
+------------------------------------------+--------------------+

: \label{params1} Kalman filter parameters used in Figure \ref{converge1} simulations. 

![Kalman filter convergence across several simulations utilizing both magnetometer and solar angle readings. Each line represents a separate simulation. The error angle is defined as the angle between the z-axis of the actual and estimated body frames.\label{converge1}](paper/img/converge1.png){ width=70% }

For each situation, the Kalman filter converges in approximately 900 seconds or 15 minutes. The mean error angle after convergence across all trials is $2.3^\circ$, which satisfies the determination requirement for ExoCube 2.

## Magnetometer-Only Determination

Since ExoCube 2 will be passing into eclipse while orbiting, it will periodically lose it's solar angle reading. For this reason, the performance of the Kalman filter was evaluated in the same situation described in the previous section but without solar angle measurements. Again, the Kalman filter parameters used are shown in Table \ref{params1}. Data from these trials are shown in Figure \ref{converge2}.

![Kalman filter convergence across several simulations with just magnetometer readings. Each line represents a separate simulation.\label{converge2}](paper/img/converge2.png){ width=70% }

With just magnetometer readings, convergence time was much more variable. Although several of the simulations depicted in Figure \ref{converge2} converge in approximately 6000 seconds, about the time for one orbit of the earth, some simulations took far longer, and some took far shorter. However, ExoCube 2 operations will be designed such that the Kalman filter is not initialized until solar angle readings are available, so the magnetometer-only convergence time is not of great importance. What is of great importance is the ability of the Kalman filter to maintain attitude knowledge when solar angle readings aren't available. After convergence, the Kalman filter in these simulations maintained a mean error angle of $3.6^\circ$, which is also within ExoCube 2's $\pm5^\circ$ requirement. Thus, the Kalman filter meets ExoCube 2 requirements even when solar angle measurements are unavailable.

One limitation of the magnetometer-only determination algorithm occurs when the spacecraft rotates at very low angular rates (< $1\frac{deg}{sec}$). At low angular rates with high-uncertainties, there becomes a larger set of attitudes that provide the same magnetic-field measurements over large time scales. This makes Kalman filter convergence very slow or sometimes impossible. Potential mitigation of this issue is discussed in the [Future Work][Future Work] section.
