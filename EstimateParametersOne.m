
% Add paths/toolboxes
addpath(genpath('../MATLAB'))
addpath('./models')
addpath('./data')
addpath(genpath('./results'))

%% optimera
% load data
d="placebo";
load(d);

model_name='hallAt';

% make folder
folderName=datestr(now,'yymmdd');

mkdir(strrep(['./results/' model_name  '/' folderName], '.txt',''))
folder=sprintf('./results/%s/%s/',model_name,folderName);

% make model
model=str2func(model_name);

% which parameters to optimize
[pNames,paramsAll]=IQMparameters(model); 
lastpI = find(contains(pNames,'alfa'))-1;
nparams=length(pNames(36:lastpI));
[paramsAll,inits]=simInit(paramsAll,EXPDATA.dosage,...
[EXPDATA.weight(1) EXPDATA.height EXPDATA.age]); % calculates initial values
limit=chi2inv(0.95,length(EXPDATA.time));

% settings
options_ps=optimoptions(@particleswarm, 'Display','iter');%,'HybridFcn',@fmincon);
options_s=optimoptions(@simulannealbnd, 'Display','iter');
ub = repmat(log(1e11),1,nparams);
lb = -ub;

% where to save
% fid = fopen([model_name,'_all_good_parameters.csv'],'a');
fid = fopen(sprintf('%s/validParams-%s.csv',folder,d),'a');

% optimize
costfunc = @(p) cost_fun(EXPDATA,model,p,fid,paramsAll,inits,pNames,limit);

[optParam_ps, mincost_ps] = particleswarm(costfunc, nparams, lb, ub, options_ps);
[optParam, mincost] = simulannealbnd(costfunc,optParam_ps, lb, ub, options_s);
fclose(fid);

% save results
save(sprintf('%s/opt(%.5f)%img-%i.mat',folder,mincost,EXPDATA.dosage(end)) ,'optParam')

%% plot
% plot_stuff(EXPDATA,model_name,optParam,folder,dosage(d,end),worker);

