function [] = plot_7_3(positiveCorona,negativeCorona,simulationLength)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
len = 1:simulationLength;
total = positiveCorona + negativeCorona;
positive_frequency = positiveCorona ./ len;
negative_frequency = positiveCorona ./ len;
figure;
plot(positiveCorona,len);
hold;
plot(negativeCorona,len);
hold;
plot(total,SimulationLength);
hold;
title('7_2')
legend({'positive Corona','negative Corona','total'})
figure;
plot(positive_frequency,len);
hold;
plot(negative_frequency,len);
hold;
title('7_2 b ')
legend({'positive Corona frequency','positiveCorona frequency '})
end

