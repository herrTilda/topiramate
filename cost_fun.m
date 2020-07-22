
function cost = cost_fun(EXPDATA,model,params,fid,paramsAll,inits,pNames,limit)

ySim=simulate_model(EXPDATA,model,params,paramsAll,inits,pNames);
cost = nansum((((EXPDATA.weight'-ySim).^2)./(1.^2)')); 

if cost< 100 %limit 
 fprintf(fid, [sprintf('%.52f, ',exp(params)) sprintf('%.52f\n',cost)]); % 
end

end
