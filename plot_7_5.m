function [] = plot_7_5(queue1Lentgh,queue1Negative,queue1Positive,simulationLength)
% Q7_5
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%q1len = queue1PositiveLength + queue1NegativeLength;
plot([1:simulationLength],queue1Lentgh);
hold;
plot([1:simulationLength],queue1Negative);
plot([1:simulationLength],queue1Positive);

end

