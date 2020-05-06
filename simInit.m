
function [paramsAll,inits]=simInit(paramsOpt,paramsAll,dosage,initInput)
% calculating initial values and inserting parameters to optimize at
% correct place

if ~isempty(dosage)
paramsAll(1:25)=dosage;
end

BWinit = initInput(1);
height = initInput(2);
age = initInput(3);

Finit = (BWinit/100)*( 0.14*age + 39.96*log(BWinit/((0.01*height)^2)) - 102.01 ); % female regression equation of Jackson and colleagues
RMRinit = 9.99*BWinit + 6.25*height - 4.92*age - 161;
RMRinit = RMRinit*4.184*10^3; %from kcal to Joule
Ginit = 0.5;
ECFinit = 0.7*0.235*BWinit;
Linit = BWinit - (Finit + Ginit + 2.7*Ginit + ECFinit);
ATinit = 0;

BW = round(Finit + Linit + (1 + 2.7)*Ginit + ECFinit);
if BW ~= BWinit
   disp("initials don't add up to initial BW") 
end

inits = [Ginit ECFinit Finit Linit ATinit];

% EIrestriction1 = EIrestriction2*4.183*10^3;

paramsAll(26:34)=[initInput RMRinit inits];

if ~isempty(paramsOpt)
paramsAll(35:(34+length(paramsOpt)))=paramsOpt;
end

end
