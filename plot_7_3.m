function [] = plot_7_3(numberOfPatientsinSystem,positive_numberOfPatientsinSystem,negative_numberOfPatientsinSystem,coronaTest)
%PLOT_7_3 Summary of this function goes here
%   Detailed explanation goes here
wait = wait1 + wait2;
positive_wait = [];
p_counter = 1;
negative_wait = [];
n_counter = 1;
number_of_patients = length(coronaTest);
for i = 1:number_of_patients
    if coronaTest(i)==1
        positive_wait(p_counter) = wait1(p_counter) + wait2(p_counter);
        p_counter = p_counter + 1;
    elseif coronaTest(i)==0
        negative_wait(n_counter) = wait1(n_counter) + wait2(n_counter);
        n_counter = n_counter + 1;
    end
end

figure
hist(wait);
 
legend('total waited time')
 
figure
hist(positive_wait);
 
legend('+ corona waited time')
figure
hist(negative_wait);
 
legend('- corona waited time')
 
% plot(negative_rosponse_time,unique(negativee_rosponse_time));
% hold;
% 
% plot(response_time,unique(response_time));
% hold;
 
 
end
