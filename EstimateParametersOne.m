
% Add whatever paths/toolboxes you need.
addpath(genpath('../MATLAB/IQMtools/'))
addpath('../MATLAB')
addpath('./models')
addpath('./data')


%% optimera
model_name='multimodelAtPKPD';

% make model and foldername
model=str2func(model_name);

folder=sprintf('./results/%s/%s/%s/',model_name,datestr(now, 'yymmdd'));

% for d=["topiramate192","topiramate96","topiramate64","placebo"]
d="placebo";
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
fid = fopen(sprintf('%s/validParams%img-%i.csv',folder,EXPDATA.dosage(end)),'wt');

% optimize
costfunc = @(p) cost_fun(EXPDATA,model,p,fid,paramsAll,inits,pNames);

[optParam_ps, mincost_ps] = particleswarm(costfunc, nparams, lb, ub, options_ps);
[optParam, mincost] = simulannealbnd(costfunc,optParam_ps, lb, ub, options_s);
fclose(fid);

% save results
save(sprintf('%s/opt(%.5f)%img-%i.mat',folder,mincost,EXPDATA.dosage(end)) ,'optParam')

%% plot
% plot_stuff(EXPDATA,model_name,optParam,folder,dosage(d,end),worker);
