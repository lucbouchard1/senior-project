
# Introduction

Attitude determination and control (ADC) software discerns and corrects the orientation of spacecraft on orbit. It is an essential component of many space missions; however, it is often tricky to implement because it's mathematically complex and difficult to test. In this work, we describe Kalman-filter based attitude determination software for Exocube 2, a mission in development at PolySat, the Cal Poly CubeSat research lab, and we provide a software-based testing framework to validate the ADC software. Furthermore, we show how this software can be easily reused on all PolySat spacecraft, reducing risk and development time on future missions. This attitude estimation solution relies on low-cost instrumentation that is already part of the generic PolySat bus, enabling even simple mission to perform attitude estimation with little additional development.

## Background

CubeSats are 10 cm cube spacecraft that began as a collaborative effort between Dr. Jordi Puig-Suari of Cal Poly and Dr. Bob Twiggs of Stanford University in 1999. Puig-Suari and Twiggs sought to reduce small satellite development time and cost by providing a rigorous mechanical standard that, if properly met, ensured satellites could fly on any launch vehicle with a CubeSat deployer at no risk to other payloads on the same launch [@cubesat].

The Cal Poly CubeSat Lab, also known as PolySat, has been developing CubeSats since 2001, steadily advancing it's technical capability with each completed mission. However, one capability that has eluded PolySat since its founding is on-orbit attitude estimation. An attempt to support this capability was made for PolySat's ExoCube mission [@arash]; however, ExoCube suffered an antenna deployment failure that severely limited potential operations, causing ADC validation to be descoped [@saunders]. Futhermore, the ADC software developed for ExoCube was specific to the mission, and porting the software to different spacecraft would require significant development effort.

## Exocube 2

Because of ExoCube's aforementioned antenna deployment failure, a reflight of the ExoCube mission is under development, known as ExoCube 2. Just like the original ExoCube, ExoCube 2 will fly a mass spectrometer suite in low earth orbit (LEO) to measure neutral and ionized molecule densities in the exosphere and thermospehere. This information is essential to physis-based weather models, and a similar measurement hasn't been made since the Dynamics Explorer 2 mission that launched in 1981 [@sellers].

Ions and neutral particles will impact Exocube 2's Ion Neutral Mass Spectrometer (INMS) at a location dependent on it's incident velocity. Because the INMS is sampling molecules moving at random velocities within the atmosphere, the instrument will identify species by measuring their velocity distribution. Kinetic gas theory provides a model for the velocity distribution of molecules of varying masses at a particular temperature. As long as the INMS is exposed to the full distribution of velocities for all species, the mass composition of the species can be determined.

To sample full velocity distribution, ExoCube 2 will point the aperture of the INMS along the orbital velocity vector of the spacecraft (ram facing direction). If the vector normal to the plane of the aperture is at an angle relative to the ram facing direction, the measured velocity distribution will be skewed, and the species could be misidentified [@sellers]. To torque the spacecraft into the ram facing direction, the attitude of the spacecraft must fist be determined. The algorithm behind this initial step is the topic of this paper.

