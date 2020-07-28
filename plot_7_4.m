function [] = plot_7_4(queue1Arrive,exitTime,coronaTest,simulationLength)
%Q7_4 Summary of this function goes here
%   Detailed explanation goes here
inSysTime = exitTime-queue1Arrive;
positive_corona_inSystime = [];
negative_corona_inSystime = [];
number_of_pattients = length(queue1Arrive);

for i=1:number_of_pattients
    if coronaTest(i) == 1
        positive_corona_inSystime = exitTime(i) - queue1Arrive(i);
    elseif  coronaTest(i) == 0
        negative_corona_inSystime = exitTime(i) - queue1Arrive(i);
    end
end 



end

