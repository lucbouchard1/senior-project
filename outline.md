Focus on kalman filtering, algorithm, implementation, and results

# Introduction (2 Pages)
   - Explain CubeSats/PolySat
   - Introduce ExoCube and mission requirements

# Statement of Problem (2 pages)
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

