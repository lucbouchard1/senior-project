# Spacecraft Dynamics

## Reference Frames

Three reference frames will be utilized throughout this paper, earth-centered inertial (ECI), local vertical local horizontal (LVLH), and body. Their definitions follow, and figure \ref{frames} shows 2D illustrations of the frames.

### ECI

The earth-centered inertial frame, also known as the geocentric equatorial frame, is a non-rotating right handed Cartesian coordinate system with its origin at the center of the Earth. The fundamental plane ($X_{ECI},\ Y_{ECI}$) consists of the Earth’s equatorial plane with the principal direction ($X_{ECI}$) pointed at the vernal equinox.  The right handed coordinate system is completed by $Z_{ECI}$ which is orthogonal to the Earth’s equatorial plane and coincides with the Earth’s axis of rotation [@curtis p. 204].

### LVLH

The LVLH frame is an Earth centered, orbit based, and rotating frame. The origin is centered at the center of mass of the spacecraft with the $Z_{LVLH}$ axis pointing towards the center of the Earth (nadir). The $Y_{LVLH}$ axis is aligned with the negative of the orbital angular momentum vector (cross-track). The right handed coordinate system is completed by $X_{LVLH}$ which is aligned with the velocity vector (in-track/ram) direction for circular orbits.

### Body

The body frame is aligned geometrically with the spacecraft. The orthogonal set of axes is defined with the origin at the geometric center of the 3U structure with $X_{Body}$, $Y_{Body}$, and $Z_{Body}$ axes normal to the X, Y, and Z sides of the CubeSat as defined by the CubeSat Standard.

![2D depictions of all three reference frames.\label{frames}](paper/img/frames.pdf){ width=50% }

## Quaternions

This paper will use quaternions to represent spacecraft attitude. Quaternions are four element vectors that can be used to represent a frame rotation. Thus the spacecraft's attitude will be represented as the frame transformation from ECI to body, or LVLH to body. In this paper, the last element of the four element vector will be the scalar component, and the first three will be the vector component. They will be notated as follows:

\begin{equation}
q = [q_i, q_j, q_k, q_r] = [\vec{q}, q_r]
\end{equation}

To represent attitude, the quaternion elements will be defined as: 

\begin{equation}
\begin{array}{l}
\vec{q} = \vec{u}\sin(\frac{\theta}{2}) \\
q_r = \cos(\frac{\theta}{2})
\end{array}
\end{equation}

where $\theta$ is the angle with which to rotate the frame, and $\vec{u}$ is a unit vector to rotate the frame around. Multiplication of two quaternions, $a$ and $b$ is defined by the Hamilton product:

\begin{equation}
   a*b = \begin{pmatrix}
      a_rb_i + a_ib_r + a_jb_k - a_kb_j \\
      a_rb_j - a_ib_k + a_jb_r + a_kb_i \\
      a_rb_k + a_ib_j - a_jb_i + a_kb_r \\
      a_rb_r - a_ib_i - a_jb_j - a_kb_k
   \end{pmatrix}
\end{equation}

The conjugate of a quaternion $q$, $q^{-1}$, is defined as:

\begin{equation}
q^{-1} = [-\vec{q}, q_r]
\end{equation}

To apply the transformation described by a quaternion $q$ to a vector $v$, the following must be performed:

\begin{equation}
v' = q*[\vec{v}, 0]*q^{-1}
\end{equation}

The transformed vector is given by the vector component of the quaternion $v'$. Note that if two quaternions, $a$ and $b$, are multiplied (i.e. $a * b$), their product represents the rotation by $b$ followed by the rotation by $a$.

## Rigid Body Dynamics

We start with Euler's equation for rotational motion, which states that:

\begin{equation} \label{euler}
\dot{\vec{L}} + (\vec{\omega} \times \vec{L}) = \vec{M}_{net}
\end{equation}

where $\vec{L}$ is the angular momentum vector of the body in the body frame, $\vec{\omega}$ is the angular velocity vector of the body frame with respect to an inertial frame, and $\vec{M}_{net}$ is the net torque on the body in the same inertial frame. Note that $\vec{L}$ is given by:

\begin{equation}
\vec{L} = I\vec{\omega}
\end{equation}

where I is the inertia matrix of the body. If the body frame is aligned with the principle axes of the body, then the inertia matrix becomes diagonal. Assuming the principle moments of inertia are given by $\lambda_x$, $\lambda_y$, and $\lambda_z$, equation (\ref{euler}) can be converted into component form:

\begin{equation} \label{rotation}
\begin{array}{l}
\lambda_x\dot{\omega}_x - (\lambda_y - \lambda_z)\omega_y\omega_z = M_x \\
\lambda_y\dot{\omega}_y - (\lambda_z - \lambda_x)\omega_z\omega_x = M_x \\
\lambda_z\dot{\omega}_z - (\lambda_x - \lambda_y)\omega_x\omega_y = M_x
\end{array}
\end{equation}

## Quaternion Kinematics

The time derivative of a quaternion can be related to the angular velocity of the target frame through the following:

\begin{equation} \label{quaternion}
   \dot{q} = \frac{1}{2}\begin{pmatrix}
      0 & \omega_z & -\omega_y & \omega_x \\
      -\omega_z & 0 & \omega_x & \omega_y \\
      \omega_y & -\omega_x & 0 & \omega_z \\
      -\omega_x & -\omega_y & -\omega_z & 0 \\
   \end{pmatrix} q
\end{equation}