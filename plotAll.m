

figure()
set(0,'DefaultLineLineWidth',2)
sgtitle('states')

nstates=length(IQMstates(model));


for k=1:nstates
subplot(2,3,1)
plot(sim.time, sim.statevalues(:,ismember(IQMstates(model),'AT')))
legend('AT')
end
