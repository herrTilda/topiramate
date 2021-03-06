
function ySim = simulate_model(EXPDATA, model, paramsOpt,paramsAll,inits,pNames)

try
   if ~isempty(paramsOpt)
    paramsAll(36:(35+length(paramsOpt)))=paramsOpt;
   end
   
   [initsAll] = simulateSteadyState(model,paramsAll,pNames,inits);
   paramsAll(ismember(pNames,'alfa'))=0;  
   paramsAll(ismember(pNames,'EIrestriction2'))=-600; 
   
   sim = model(EXPDATA.time, initsAll, paramsAll); 
   %plot_other_stuff(sim)
   ySim = sim.variablevalues(:,ismember(IQMvariables(model),'BW'))'; 
catch error
   disp(getReport(error))
   ySim=deal(inf*ones(size(EXPDATA.time))');
end
end
