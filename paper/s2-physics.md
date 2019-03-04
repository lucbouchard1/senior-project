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
