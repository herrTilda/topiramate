function [] = plot_stuff(EXPDATA,model)

% allParams = dlmread(sprintf('%s/validParams%i-%i.csv',folder,dosage,worker),'wt');
% %allParams = dlmread('M4_all_good_parameters.csv');
% sampledParams = sample_params(100,allParams);
% boundries=get_maxmin(sim_time, model_name, squeeze(sampledParams),DATA);

%% plot

% nice colors
% cDat = [0.517647058823530,0.235294117647059,0.047058823529412];
% cSim = [0.184313725490196,0.321568627450980,0.560784313725490]; 

paramsOpt=[];

% plot weight
simTime=[0:0.01:EXPDATA.time(end)];
[pNames,paramsAll]=IQMparameters(model); 
sim = simulateAll(EXPDATA, model,paramsOpt,paramsAll,pNames);

figure()

xlabel('Time (days)');
ylabel('Body weight (kg)');
title('Weight-loss over time');
box off
set (gcf, 'PaperPositionMode','auto','Units', 'normalized');%, 'outerposition', [0,0.05,0.4,0.4]);  
plot(sim.time, sim.variablevalues(:,ismember(IQMvariables(model),'BW'))); hold on
% h=fill([time fliplr(time)],[min' fliplr(max')],...
%     cSim,'FaceAlpha',.3,'EdgeAlpha',.3); hold on
% set(h,'EdgeColor','None'); hold on

plot(EXPDATA.time,EXPDATA.weight,'.','MarkerSize',20);
axis tight

plotMoore(sim,model,'placebo')

%----------------functions-----------------

function []=plotBar(color,AUCdata,AUCsim,i)

    s=bar(i,AUCsim,'FaceColor',color,'EdgeColor','none');hold on
    if ~isempty(AUCdata)
        d=bar(i+1,AUCdata,'FaceColor',color.*(1/2),'EdgeColor','none');hold on
    end
    %legend([d,s],'data','sim');
end

end