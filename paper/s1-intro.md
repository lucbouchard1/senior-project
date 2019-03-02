
# Introduction

Attitude determination and control (ADC) software discerns and corrects the orientation of spacecraft on orbit. It is an essential component of many space missions; however, it is often tricky to implement because it's mathematically complex and difficult to test. In this work, we describe Kalman-filter based attitude determination software for Exocube 2, a mission in development at PolySat, the Cal Poly CubeSat research lab, and we provide a software-based testing framework to validate the ADC software. Furthermore, we show how this software can be easily reused on all PolySat spacecraft, reducing risk and development time on future missions. This attitude estimation solution relies on low-cost instrumentation that is already part of the generic PolySat bus, enabling even simple mission to perform attitude estimation with little additional development.

## Background

CubeSats are 10 cm cube spacecraft that began as a collaborative effort between Dr. Jordi Puig-Suari of Cal Poly and Dr. Bob Twiggs of Stanford University in 1999. Puig-Suari and Twiggs sought to reduce small satellite development time and cost by providing a rigorous mechanical standard that, if properly met, ensured satellites could fly on any launch vehicle with a CubeSat deployer at no risk to other payloads on the same launch.

The Cal Poly CubeSat Lab, also known as PolySat, has been developing CubeSats since 2001, steadily advancing it's technical capability with each completed mission. However, one capability that has eluded PolySat since its founding is on-orbit attitude estimation.

An attempt to support this capability was made for PolySat's ExoCube mission [@arash]; however, ExoCube suffered an antenna deployment failure that severely limited potential operations, causing ADC validation to be descoped. Futhermore, the software attitude determination software developed for exocube was 

\begin{center}
\begin{math}
   x = 24
\end{math}
\end{center}

\newpage

Wow look at that! Check out the [intro section](#introduction)

\newpage
# References
