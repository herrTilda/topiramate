
close all

load placebo
IQMmakeMEXmodel(IQMmodel('hallAtPKPD.txt'))
model_name='hallAtPKPD';
model=str2func(model_name);
% [pNames,paramsAll]=IQMparameters(model); 
[model,paramsAll,pNames,inits]=simInit(model_name,[],EXPDATA.dosage,...
       [EXPDATA.weight(1) EXPDATA.height EXPDATA.age]);
[initsAll] = simulateSteadyState(model, paramsAll,pNames,inits);

paramsAll(ismember(pNames,'EIrestriction2'))=-600; 
paramsAll(ismember(pNames,'alfa'))=1; 
sim = model([0:0.01:360], initsAll, paramsAll); 

plot_other_stuff(sim,model,'experiment simulation')

