function [initsAll] = simulateSteadyState(model, paramsAll,pNames,inits)

simTimeEnd=20000000000000;

   paramsAll(ismember(pNames,'EIrestriction2'))=0; 
   paramsAll(ismember(pNames,'alfa'))=0; 
   
   initsAll = IQMinitialconditions(model);
   initsAll(1:5) = inits; 
   time=[1:simTimeEnd-100:simTimeEnd];
   sim = model(time, initsAll, paramsAll); 
   
   initsAll = sim.statevalues(end,:);
   initsAll(3:5) = inits(3:5); 

 %plot_other_stuff(sim,model,'steady state')

end
