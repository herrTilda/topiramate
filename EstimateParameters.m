function [] =  EstimateParameters(worker,folderName)

 s=rng('shuffle'); %do not note remove this line
 s=rng(s.Seed+worker); %do not note remove this line
 
 if nargin<2 || isempty(folderName)
    folderName='Temp';
 end

addpath(genpath('../MATLAB'))
addpath('./models')
addpath('./data')
addpath(genpath('./results'))


% load data
d="placebo";
load(d);

model_name='hallOrig';

% make model and foldername
model=str2func(model_name);

folder=sprintf('./results/%s/%s/',model_name,folderName);

% for d=["topiramate192","topiramate96","topiramate64","placebo"]

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
ub = repmat(log(1e12),1,nparams);
lb = -ub;

% where to save
fid = fopen(sprintf('%s/validParams-%s.csv',folder,d),'a');

% optimize
costfunc = @(p) cost_fun(EXPDATA,model,p,fid,paramsAll,inits,pNames,limit);

[optParam_ps, mincost_ps] = particleswarm(costfunc, nparams, lb, ub, options_ps);
[optParam, mincost] = simulannealbnd(costfunc,optParam_ps, lb, ub, options_s);
fclose(fid);

% save results
save(sprintf('%s/opt(%.5f)%img-%i.mat',folder,mincost,EXPDATA.dosage(end),s.Seed) ,'optParam')

end
