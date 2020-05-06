function [] = plot_stuff(DATA,model_name,optParam,folder,dosage,worker)

allParams = dlmread(sprintf('%s/validParams%i-%i.csv',folder,dosage,worker),'wt');
%allParams = dlmread('M4_all_good_parameters.csv');
sampledParams = sample_params(100,allParams);
boundries=get_maxmin(sim_time, model_name, squeeze(sampledParams),DATA);

%% plot

% nice colors
cDat = [0.517647058823530,0.235294117647059,0.047058823529412];
cSim = [0.184313725490196,0.321568627450980,0.560784313725490]; 

% plot weight
endtime=DATA(end,1);
simTime=[0:0.01:endtime];
sim_days = model(', inits_total, params);

figure()

xlabel('Time (days)');
ylabel('Body weight (kg)');
title('Weight-loss over time');
box off
set (gcf, 'PaperPositionMode','auto','Units', 'normalized');%, 'outerposition', [0,0.05,0.4,0.4]);  
plot(time, sim,'linewidth',thickness,'Color',cSim); hold on
h=fill([time fliplr(time)],[min' fliplr(max')],...
    cSim,'FaceAlpha',.3,'EdgeAlpha',.3); hold on
set(h,'EdgeColor','None'); hold on

plot(DATA(:,1),DATA(:,2),'.','Color',cDat,'MarkerSize',20);
axis tight

set (gca,'Color',cBack)

%----------------functions-----------------

function []=plotBar(color,AUCdata,AUCsim,i)

    s=bar(i,AUCsim,'FaceColor',color,'EdgeColor','none');hold on
    if ~isempty(AUCdata)
        d=bar(i+1,AUCdata,'FaceColor',color.*(1/2),'EdgeColor','none');hold on
    end
    %legend([d,s],'data','sim');
end

end