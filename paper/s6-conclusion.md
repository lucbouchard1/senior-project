
# Conclusion

This work implemented a Kalman filter in C to determine the attitude of ExoCube2 on-orbit using magnetometer and solar angle measurements. This implementation was tested extensively using a software-based testing framework built of NASA's "42" spacecraft dynamics simulator, and the software was designed to be reusable on future PolySat missions using a robust software architecture. Simulating the uncertainties expected from ExoCube 2's instrumentation, the Kalman filter was found to converge to the spacecraft's true attitude in approximately 15 minutes and maintain an attitude knowledge of $2.3^\circ$. If solar angle measurements were lost due to the spacecraft passing into eclipse, the Kalman filter was found to maintain an attitude knowledge of $3.6^\circ$. Both of these uncertainties are within ExoCube 2's $\pm 5^\circ$ attitude knowledge requirement.

Because the Kalman filter was found to converge even when only magnetometers were used, this software could be used in any PolySat spacecraft with little development time, as every PolySat spacecraft includes magnetometers as part of the generic hardware. This is an enabling technology for the PolySat lab.

## Future Work

This work put little effort or analysis into the selection of the Kalman filter parameters. More thoughtful selection of the process noise matrix ($Q$) and the initial covariance matrix ($P$) could yield significant improvements in the filter's convergence time and steady-state error.

Furthermore, the seven-dimensional filter employed in this work has a singular covariance matrix due to the norm-constraint on the quaternion [@early_kalman]. This can lead to numerical instabilities that produce non-optimal filter performance. One algorithm to avoid these instabilities is the Multiplicative Extended Kalman Filter (MEKF). This may have the added benefit of improving filter performance at low angular velocities, which could resolve the problem described in the [Magnetometer-Only Determination][Magnetometer-Only Determination] section above.

# Acknowledgments

I first want to thank all the PolySat faculty and students that came before me and layed the groundwork for this research, specifically Dr. Jordi Puig-Suari, Ryan Sellers, and Arash Mehrparvar.

I absolutely must thank Dr. John Bellardo for lending me his infinite wisdom not just in this project, but throughout my undergraduate career.

Dr. Matt Moelter, thank you dearly for your mentorship over these last two quarters.

Thanks to all the wonderful student engineers I've worked with at PolySat over the last four years. Special thanks to Liam Bruno for leading my feeble physics brain through the treacherous landscape of spacecraft controls.

Thanks to my girlfriend, Mari Friedman, and to anyone else who has supported me through this project and through my time at Cal Poly.

And finally, thanks to my parents, Helene and Louis Bouchard, who are ultimately responsible for the existence of this project. Thanks for your endless support.