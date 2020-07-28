function [] = queue_length(queue1NegativeLength,queue1PositiveLength,simulationLength)
% Q7_5
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
q1len = queue1PositiveLength + queue1NegativeLength;
plot(queue1NegativeLength,simulationLength);
hold;
plot(queue1PositiveLength,simulationLength);
hold;
plot(q1len,simulationLength);
hold;
legend({'NegativereceptionQueueLength','PositivereceptionQueueLength','total reception queue length'})
end

