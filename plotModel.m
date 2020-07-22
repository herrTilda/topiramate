% compile and plot modell

% load data
d="topiramate64";
load(d);

model_name='hallAtEE';
IQMmakeMEXmodel(IQMmodel([model_name '.txt']))
model=str2func(model_name);

plot_stuff(EXPDATA,model)
