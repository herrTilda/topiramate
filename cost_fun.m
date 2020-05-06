
function cost = cost_fun(EXPDATA,model,params,fid)

limit=chi2inv(0.95,length(EXPDATA.time));

ySim=simulate_model(EXPDATA,model,params);
cost = nansum((((EXPDATA.weight'-ySim).^2)./(1.^2)')); 

if cost< limit 
 fprintf(fid, [sprintf('%.52f, ',exp(params)) sprintf('%.52f\n',cost)]); % 
end

end
