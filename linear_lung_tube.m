% This file describes and executes the simulink model of a pacient lung and
% tubing equipment.
% It corresponds to pure implementation of the linear model published on:
%  * Borrello, Mike. "Modeling and control of systems for critical care ven
%    tilation." Proceedings of the 2005, American Control Conference, 2005.
%    IEEE, 2005.




%% Model Parameters

Rl = 2/1000   % [cmH2O/mL/sec] Lung resistance = airway resistance + tissue resistance
              % (normal airway resistance is estimated at 2 to 3 cm H2O/L/sec)
              % (Tissue resistance accounts for only about 20%)

Rt = Rl/100   % [cmH2O/mL/sec] Tube resistance
              % (For adult pacients Rt << Rl)


El = 1/50     % [cmH20/ml] Lung elastance (Typical range:  )
              % (inverse of compliance, i.e. 1/Cl)
              % Compliance: - typically 50 ml/cmH2O in adults and proportionally less in kids.
              %             - ARDS patients typically have a CSTAT of around 35–45 ml/cmH2O

Et = 1/2      % [cmH20/ml] Tube elastance
              % (Typical range: see Compliance of the Tubing Compartment of Lung Ventilators G. Verheecke 1 and A. Gilbertson)
              % (inverse of compliance, i.e. 1/Ct)

% Note that the real system is nonlinear and this parameters depend on the
% operation point


%% Disturbance
% - Pm:      [cmH2O] Pacient respiratory effort (pressure exerted by muscles)
             % (Typical range:  )
Pm_power = 10^-6


%% Model Inputs
% - Q:       [ml/sec] ventilation flow
             % (Typical range:  0  to  120  lpm???)
Q = 200

% - T:       [sec] Respiratory period
             % (Typical range: 4 sec)
T = 4

Pulse_width = 50 % Percentage


%% Model Outputs

% Pressure-Controlled Ventilation (PCV) or Pressure Based Ventilation (PBV)
% - Pc:      [cmH2O] Circuit pressure
             % (Typical range:  )

% Volume-Controlled Ventilation (VCV)
% - Ql:      [ml/sec] Flow into the lung
             % (Typical range:  )

             
%% Set Parameters

% - Peep:    [cmH2O] Applied (extrinsic) Positive End-Expiratory Pressure (PEEP)
             % (Typical range: 4 to 5 cmH2O)
             
% - Vt:      [ml] Tidal volume (Lung volume)
             % (young human adult, tidal volume is approximately 500 mL)

% - Qpset:   [ml/s] Peak flow

% - 1/T:     [cicles/min] = Respiratory rate
             % (% - Normal respiratory rate is about 15 breaths per minute)
 
% MISSING:

% - Intrisinc PEEP
% - Peak pressure (PIP)
% - Pleateau pressure (Pplat)
% - Driving pressure

%% Notes:

% More info at: 
%   - http://www.anaesthesia.med.usyd.edu.au/resources/lectures/ventilation_clt/ventilation.html
%   - https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6212352/
%   - http://www.ubccriticalcaremedicine.ca/rotating/material/Lecture_1%20for%20Residents.pdf
%   - http://www.scielo.br/scielo.php?pid=S0103-507X2008000300002&script=sci_arttext&tlng=en




%% Running Simulink
finalTime = 12;
simOut = sim('linear_lung_tube_model','SimulationMode','normal');
A = simOut.get('yout');
assignin('base','A', A);

% Getting Outputs
Ql = A.get('Ql').Values.Data;
Pc = A.get('Pc').Values.Data;
Qin = A.get('Qin').Values.Data;
Pm_in = A.get('Pm_in').Values.Data;

time = A.get('Ql').Values.Time;
time_Qin = A.get('Qin').Values.Time;

% Plots
figure

% subplot(2,1,1)
% plot(time_Qin, Qin)
% grid on
% title('Q(ml/s) vs Time (s)')
% legend({'Q(ml/s)'},'FontSize',12)
% axis([0 finalTime -Q*1.2 Q*1.2])

subplot(2,1,1)
plot(time, Ql)
grid on
title('Ql(ml/s) vs Time (s)')
legend({'Ql(ml/s)'},'FontSize',12)
axis([0 finalTime -Q*1.2 Q*1.2])

subplot(2,1,2)
plot(time, Pc)
grid on
title('Pc(cmH20) vs Time (s)')
legend({'Pc(cmH20)'},'FontSize',12)