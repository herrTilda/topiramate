
function sim = simulateAll(EXPDATA, model, paramsOpt,paramsAll,pNames)

try
   if ~isempty(paramsOpt)
    paramsAll(35:(34+length(paramsOpt)))=paramsOpt;
   end
   
   [paramsAll,inits]=simInit(paramsAll,EXPDATA.dosage,...
       [EXPDATA.weight(1) EXPDATA.height EXPDATA.age]);
   [initsAll] = simulateSteadyState(model,paramsAll,pNames,inits);
   
   paramsAll(ismember(pNames,'EIrestriction2'))=-600; 
   paramsAll(ismember(pNames,'alfa'))=1;  
   
   sim = model(EXPDATA.time, initsAll, paramsAll); 
catch error
   disp(getReport(error))
end
end
