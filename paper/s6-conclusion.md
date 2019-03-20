
# Conclusion

This work implemented a Kalman filter in C to determine the attitude of PolySat's ExoCube 2 using magnetometer and solar angle measurements. This implementation was tested extensively using a software-based testing framework built off NASA's open-source spacecraft dynamics simulator "42", and the software was designed to be reusable on future PolySat missions using a robust software architecture. Simulating the uncertainties expected from ExoCube 2's instrumentation, the Kalman filter converged to the spacecraft's true attitude in approximately 15 minutes and maintained an attitude knowledge with $2.3^\circ$ mean error. If solar angle measurements were lost due to the spacecraft passing into eclipse, the Kalman filter still maintained an attitude knowledge with a mean of $3.6^\circ$ error. Both of these uncertainties are within ExoCube 2's $\pm 5^\circ$ attitude knowledge requirement.

Because the Kalman filter converged even when just magnetometer readings were available, this software could be used in any PolySat spacecraft with little development time, as all PolySat spacecraft include magnetometers as part of the generic hardware. Thus, the software described in this paper is an enabling technology for the PolySat lab.

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