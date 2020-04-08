#############################################
Control loop for an AMBU-bag based ventilator
#############################################


Description
###########

This repository contains a control scheme and MATLAB/Simulink
models for the COVID-19 Ambu-bag based ventilator system and subsystems.
See parent repository and related issue for further info:
https://gitlab.com/open-source-ventilator/ventilator/OpenLung/-/issues/77#note_313225355

This repository intends to accomplish the following:

1) Simple (linearized) but representative mathematical
   model of the entire system including Ambu-bag and actuators.

2) Design of a simple controller that is robust enough to
   a variety of payloads (different patients).

3) If 2) is not feasible, the design of an adaptive controller
   for the sake of robustness.


Files
#####

- linear_lung_tube_model.slx: Simulink linear model
  of a patient's lung and tubing equipment based on [1].

- linear_lung_tube.m: Matlab M-script that runs the
  linear_lung_tube_model.slx model.


Repository Policies
###################

Feel free to add as many files, models, equations, etc, as needed, however make
file names and descriptions either in a self-contained fashion or include an
explanation section on README.rst.


References
##########

- [1]: Borrello, Mike. "Modeling and control of systems for critical care ventilation."
       Proceedings of the 2005, American Control Conference, 2005. IEEE, 2005.

- [2]: Hoffmann, Christian. "Design and Control of a Novel Portable Mechanical Ventilator."