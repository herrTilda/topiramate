
function []=plotMoore(sim,model,titel)
% -----------------------cell signaling------------------------------

% -----------------------plasma glucose------------------------------

% --------------------------weight-----------------------------------

figure()
set(0,'DefaultLineLineWidth',2)
sgtitle(titel)
subplot(2,3,1)
plot(sim.time, sim.statevalues(:,ismember(IQMstates(model),'AT')))
legend('AT')

subplot(2,3,2)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.statevalues(:,ismember(IQMstates(model),'F')))
legend('F')

subplot(2,3,3)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.statevalues(:,ismember(IQMstates(model),'L')))
legend('L')

subplot(2,3,4)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.statevalues(:,ismember(IQMstates(model),'ECF')))
legend('ECF')

subplot(2,3,5)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.statevalues(:,ismember(IQMstates(model),'G')))
legend('G')

subplot(2,3,6)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'BW')))
legend('BW')



figure()
set(0,'DefaultLineLineWidth',2)
sgtitle(titel)
subplot(2,3,1)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EE')))
legend('EE')

subplot(2,3,2)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EIn')))
legend('EIn')

subplot(2,3,3)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'CIn')))
legend('CIn')

subplot(2,3,4)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'dosage')))
legend('dosage')

subplot(2,3,5)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EIrestriction1')))
legend('EIrestriction1')

subplot(2,3,6)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EInvalue')))
legend('EInvalue')


figure()
set(0,'DefaultLineLineWidth',2)
sgtitle(titel)
subplot(2,3,1)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EE')))
legend('KK')

subplot(2,3,2)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EIn')))
legend('TEF')

subplot(2,3,3)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'CIn')))
legend('CC')

subplot(2,3,4)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'dosage')))
legend('p')

subplot(2,3,5)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EIrestriction1')))
legend('kg')

subplot(2,3,6)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EInvalue')))
legend('PAL')



figure()
set(0,'DefaultLineLineWidth',2)
sgtitle(titel)
subplot(2,3,1)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EE')))
legend('EEinit')

subplot(2,3,2)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EIn')))
legend('RMRinit')

subplot(2,3,3)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'CIn')))
legend('CIinit')

subplot(2,3,4)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'dosage')))
legend('p')

subplot(2,3,5)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EIrestriction1')))
legend('kg')

subplot(2,3,6)
set(0,'DefaultLineLineWidth',2)
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'EInvalue')))
legend('PAL')

end
