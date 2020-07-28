function [] = plot_response_time(simulationLength,enteranceTime,receptionTime,... 
    enteranceTime2,receptionTime2)
% Q 7 2
%PLOT_RESPONSE_TIME Summary of this function goes here
%   Detailed explanation goes here


response_time1 = receptionTime-enteranceTime
response_time2 = receptionTime2-enteranceTime2 
plot(simulationLength,response_time1)
hold
plot(simulationLength,response_time2)


end

