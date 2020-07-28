function [] = plot_7_1(q1arrive,receptionArrive,coronaTest)
%PLOT_7_1 Summary of this function goes here
%   Detailed explanation goes here
response_time = receptionArrive - q1arrive;
positive_rosponse_time  = [];
negative_rosponse_time  = [];
number_of_patients = length(coronaTest);
for i = 1:number_of_patients
    if coronaTest(i)==1
        positive_rosponse_time(i) = q1arrive(i)-receptionArrive(i);
    elseif coronaTest(i)==0
        negative_rosponse_time(i) = q1arrive(i)-receptionArrive(i);
    end
end

plot(positive_rosponse_time,unique(positive_rosponse_time));
hold;

plot(negative_rosponse_time,unique(negativee_rosponse_time));
hold;

plot(response_time,unique(response_time));
hold;

legend({'positive response time','negative response time','total response time'})
end

