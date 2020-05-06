function [] = plotUncertainty(color,var,boundries,sim_time)
    h=fill([sim_time fliplr(sim_time)], ...
        [boundries{var,'Max'}(:,1:length(sim_time)) fliplr(boundries{var,'Min'}(:,1:length(sim_time)))],...
        color,'FaceAlpha',.3,'EdgeAlpha',.3); hold on
    set(h,'EdgeColor','None');
    
end