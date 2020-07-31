function [] = plot_7_1(q1arrive,receptionArrive,coronaTest)
%PLOT_7_1 Summary of this function goes here
%   Detailed explanation goes here
response_time = receptionArrive - q1arrive;
positive_rosponse_time  = [];
p_counter=1;
negative_rosponse_time  = [];
n_counter=1;
number_of_patients = length(coronaTest);
for i = 1:number_of_patients
    if coronaTest(i)==1
        positive_rosponse_time(p_counter) = -q1arrive(p_counter)+receptionArrive(p_counter);
        p_counter = p_counter + 1;
    elseif coronaTest(i)==0
        negative_rosponse_time(n_counter) = -q1arrive(n_counter)+receptionArrive(n_counter);
        n_counter = n_counter + 1;
    end
end

figure
hist(response_time);
title('response time of all patients')
xlabel('response time')
ylabel('number of patinets')
 
figure
hist(positive_rosponse_time);
title('response time of patients with + corona test')
xlabel('response time')
ylabel('number of patinets')
 


figure
hist(negative_rosponse_time);
title('response time of patients with - corona test')
xlabel('response time')
ylabel('number of patinets')

 
% plot(negative_rosponse_time,unique(negativee_rosponse_time));
% hold;
% 
% plot(response_time,unique(response_time));
% hold;
 
 
end
