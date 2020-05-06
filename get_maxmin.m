function [boundries]=get_maxmin(sim_time, model_name, params,DATA)

    for k=1:size(params,1)
         simVal = simulate_model_(sim_time, model_name, params(k,:)');

            if k == 1
                minVal=simVal;
                maxVal=minVal;
            end
            if max(abs(simVal(:,:)))<inf
                if max(DATA.Adipose-DATA.SEM2)<simVal(2,:)<min(DATA.Adipose+DATA.SEM2)
                maxVal(maxVal<simVal)=simVal(maxVal<simVal);
                minVal(minVal>simVal)=simVal(minVal>simVal);
                end
            end
    end
        
boundries=table(minVal, maxVal,'VariableNames',{'Max','Min'},'RowNames',{'m','a'});

end