
# Kalman Filter

In determining the attitude of a spacecraft, several challenges must be overcome to get a stable and consistent estimate. The most obvious of these challenges is noise in the magnetometer and solar angle sensor measurements. The spacecraft's magnetometers, while being limited in resolution for one, are also constantly being exposed to magnetic field fluctuations resulting from surrounding electronics. On top of this, for magnetic field measurements to useful in an attitude estimate, they must be compared to a reference for the earth's magnetic field at the measurement location, which has it's own associated uncertainty. Solar angle sensors suffer from similar uncertainties, but the have added challenge of being unusable when the sun is eclipsed by the earth. Thus, the determination algorithm must be able to accommodate the spontaneous loss of these measurements.

To solve this challenges, an Extended Kalman Filter (EKF) was designed and implemented. Kalman Filters use Bayesian statistics to combine noisy sensor readings with a mathematical model of the system in question [@kalman]. The filter used in this work uses a seven-dimensional state vector, $\vec{x}$ given by:

\begin{equation}
\vec{x} = (\omega_x, \omega_y, \omega_z, q_s, q_i, q_j, q_k)
\end{equation}

where the angular velocities are of the body frame with respect to ECI and the quaternion values rotate from ECI to body. The predict step of the kalman filter is accomplished by propagating the time derivative of the state vector using the Euler method. This equation is derived using equations \ref{rotation} and \ref{quaternion}:

\begin{equation}
\dot{\vec{x}} = \vec{f}(\vec{x}) = \begin{pmatrix}
            \dot{\omega_0} \\
            \dot{\omega_1} \\
            \dot{\omega_2} \\
            \dot{q_s} \\
            \dot{q_i} \\
            \dot{q_j} \\
            \dot{q_k} \\
         \end{pmatrix} = \begin{pmatrix}
                           I_x^{-1}(I_y - I_z)*\omega_y*\omega_z \\
                           I_y^{-1}(I_z - I_x)*\omega_x*\omega_z \\
                           I_z^{-1}(I_x - I_y)*\omega_x*\omega_y \\
                           \frac{1}{2}(\omega_zq_j - \omega_yq_k + \omega_xq_r) \\
                           \frac{1}{2}(-\omega_zq_i + \omega_xq_k + \omega_yq_r) \\
                           \frac{1}{2}(\omega_yq_i - \omega_xq_j + \omega_zq_r)  \\
                           \frac{1}{2}(-\omega_xq_i - \omega_yq_j - \omega_zq_k) \\
                        \end{pmatrix}
\end{equation}

Note that the above assumes the body frame is aligned with the spacecraft's principle axes and that there are no control torques. Since this paper is focused on determination, we will ignore control torques. The nonlinear terms in the above equation is what motivates using a EKF over a generic linear Kalman filter. The discrete state transition matrix, $F$, for this system is approximately given by:

\begin{equation}
F \approx I + \frac{\partial\vec{f}(\vec{x}_+)}{\partial\vec{x}}dt
\end{equation}

where $I$ is the identity matrix and $\vec{x}_+$ is the state vector of the previous current state, and $dt$ is the change in time between the current state and the next state. The measurement vector of the EKF, $\vec{z}$ is given by:

\begin{equation}
\vec{z} = (b_x, b_y, b_z, s_x, s_y, s_z)
\end{equation}

where $\vec{b} = (b_x, b_y, b_z)$ is the magnetic field measurement in body and $\vec{s} = (s_x, s_y, s_z)$ is the solar vector measurement in body. The measurement model, $\vec{h}(\vec{x})$ is given by:

\begin{equation}
\vec{z} = \vec{h}(\vec{x}) = 
\end{equation}