function [] =  EstimateParameters(worker,folderName)
 s=rng('shuffle'); %do not note remove this line
 s=rng(s.Seed+worker); %do not note remove this line

% Add whatever paths/toolboxes you need.
addpath(genpath('../MATLAB/IQMtools/'))
addpath('../MATLAB')
addpath('./models')
addpath('./data')

% get names of all models to try
cd Models
models=dir('*.txt');
cd ..

%% optimera
for k = 1:length(models)
 model_name=erase(models(k).name,".txt");
% make model and foldername
model=str2func(model_name);
folder=sprintf('./results/%s/',model_name,folderName);

% which parameters to optimize
[pNames,~]=IQMparameters(model); 
lastpI = find(contains(pNames,'alfa'))-1;
nparams=length(pNames(35:lastpI));

for d=["topiramate192","topiramate96","topiramate64","placebo"]
load(d);
options_ps=optimoptions(@particleswarm, 'Display','iter');%,'HybridFcn',@fmincon);
options_s=optimoptions(@simulannealbnd, 'Display','iter');
ub = repmat(log(1e9),1,nparams);
lb = -ub;

fid = fopen(sprintf('%s/validParams%img-%i.csv',folder,EXPDATA.dosage(end),worker),'w+');
% fid = fopen([model_name,'_all_good_parameters.csv'],'w+');

costfunc = @(p) cost_fun(EXPDATA,model,p,fid);

[optParam_ps, mincost_ps] = particleswarm(costfunc, nparams, lb, ub, options_ps);
[optParam, mincost] = simulannealbnd(costfunc,optParam_ps, lb, ub, options_s);
fclose(fid);

% Save results
save(sprintf('%s/opt(%.5f)%img-%i.mat',folder,mincost,EXPDATA.dosage(end),worker) ,'optParam')

%% plot
% plot_stuff(DATA,model_name,optParam,folder,dosage(d,end),worker);
clear EXPDATA
end
clear model
end
end
