function [] =  EstimateParameters(worker,folderName)

 s=rng('shuffle'); %do not note remove this line
 s=rng(s.Seed+worker); %do not note remove this line
 
 if nargin<2 || isempty(folderName)
    folderName='Temp';
 end

% Add whatever paths/toolboxes you need.
addpath(genpath('../MATLAB/IQMtools/'))
addpath('../MATLAB')
addpath('./models')
addpath('./data')

% get names of all models to try
cd models
models=dir('*.txt');
cd ..

%% optimera
for k = 1:length(models)
 model_name=erase(models(k).name,".txt");
% model_name='hallAt';
% make model and foldername
model=str2func(model_name);

folder=sprintf('./results/%s/%s/%s/',model_name,folderName);

for d=["topiramate192","topiramate96","topiramate64","placebo"]
% d="placebo";
load(d);

% which parameters to optimize
[pNames,paramsAll]=IQMparameters(model); 
lastpI = find(contains(pNames,'alfa'))-1;
nparams=length(pNames(35:lastpI));
[paramsAll,inits]=simInit(paramsAll,EXPDATA.dosage,...
[EXPDATA.weight(1) EXPDATA.height EXPDATA.age]);

% settings
options_ps=optimoptions(@particleswarm, 'Display','iter');%,'HybridFcn',@fmincon);
options_s=optimoptions(@simulannealbnd, 'Display','iter');
ub = repmat(log(1e9),1,nparams);
lb = -ub;

% where to save
fid = fopen(sprintf('%s/validParams%img-%i.csv',folder,EXPDATA.dosage(end),s.Seed),'wt');
% fid = fopen([model_name,'_all_good_parameters.csv'],'w+');

% optimize
costfunc = @(p) cost_fun(EXPDATA,model,p,fid,paramsAll,inits,pNames);

[optParam_ps, mincost_ps] = particleswarm(costfunc, nparams, lb, ub, options_ps);
[optParam, mincost] = simulannealbnd(costfunc,optParam_ps, lb, ub, options_s);
fclose(fid);

% save results
save(sprintf('%s/opt(%.5f)%img-%i.mat',folder,mincost,EXPDATA.dosage(end),s.Seed) ,'optParam')

%% plot
% plot_stuff(EXPDATA,model_name,optParam,folder,dosage(d,end),worker);
clear EXPDATA
end
clear model
end
end
