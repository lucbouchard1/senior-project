Focus on kalman filtering, algorithm, implementation, and results

# Introduction/Statement of Problem (2 Pages)
   - Intro Paragraphs
   - Background
      - History of CubeSat and PolySat Lab
   - Exocube 1
      - Explain why Exocube 1 ADCS is no good, including how it was specific to the mission. Explain failure.
   - Exocube 2
      - Explain goals within Exocube 2 (explain determination requirements here)
      - Explain how we want to do more testing
   - Generalizing the Software
      - Explain how we want the software developed to Exocube 2 to scale to all spacecraft.

   - Explain CubeSats/PolySat
   - Introduce ExoCube and mission requirements
   - Many CubeSats need to do attitude determination to meet mission requirements
      - Often have pointing requirements
   - Kalman filtering allows converting noisy sensor measurements into accurate attitude estimates
   - This kalman filter implementation needs to be generic to PolySat spacecraft so it can be reused in the future
   - Goals:
      - Extensible and reusable kalman filter for CubeSats

# Math/Physics Background (4 pages)
   - Frames
   - Attitude representation (quaternions)
   - Spacecraft dynamics

# Kalman Filtering Introduction (2 pages)
   - Talk about the basic principles of Kalman/statistical filters

# Kalman Filter Implementation (2 pages)
   - Description of the Kalman filtering algorithm employed for ExoCube

# Software Architecture Description (4 pages)
   - How the ExoCube algorithm was implemented in code
   - Talk about object model and how this achieves reusability

# Kalman Filter Implementation Results (4 pages)
   - Explain how the filter was tested (nasa42 dynamics simulator)
   - Show the results of the testing

# Conclusions and Future Work (2 pages)

