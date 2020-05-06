
function [sampledParams] = sample_params(nsets,allParams)

% allocation
np=size(allParams,2)-1;
sets=floor(linspace(1,size(allParams,1),nsets));
sampledParams=nan(nsets,np);

% sample
allParams=sortrows(allParams,(np+1));
sampledParams(:,:)=allParams(sets,1:np);

end
