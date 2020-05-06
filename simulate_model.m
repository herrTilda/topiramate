
function ySim = simulate_model(EXPDATA, model, params)

try
   [pNames,paramsAll]=IQMparameters(model);
   [paramsAll,inits]=simInit(params,paramsAll,EXPDATA.dosage,...
   [EXPDATA.weight(1) EXPDATA.height EXPDATA.age]);
   paramsAll(ismember(pNames,'BWinit'))=EXPDATA.weight(1);
   paramsAll(ismember(pNames,'EIrestriction2'))=0;  
   [initsAll] = simulateSteadyState(model,paramsAll,pNames,inits);
   paramsAll(ismember(pNames,'EIrestriction2'))=-600; 
   
   sim = model(EXPDATA.time, initsAll, paramsAll); 
   %plot_other_stuff(sim)
   ySim = sim.variablevalues(:,ismember(IQMvariables(model),'BW'))'; 
catch error
   disp(getReport(error))
   ySim=deal(inf*ones(size(EXPDATA.time))');
end
end
