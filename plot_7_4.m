function [] = plot_7_4(queue1Arrive,exitTime,coronaTest)
%Q7_4 Summary of this function goes here
%   Detailed explanation goes here
inSysTime = exitTime-queue1Arrive;
positive_corona_inSystime = [];
negative_corona_inSystime = [];
number_of_pattients = length(queue1Arrive);
p_counter=1;
n_counter=1;

for i=1:number_of_pattients
    if coronaTest(i) == 1
        positive_corona_inSystime(p_counter) = exitTime(p_counter) - queue1Arrive(p_counter);
         p_counter = p_counter + 1;
    elseif  coronaTest(n_counter) == 0
        negative_corona_inSystime(n_counter) = exitTime(n_counter) - queue1Arrive(n_counter);
        n_counter = n_counter+1;
    end
end 

%disp(inSysTime)
%disp(number_of_pattients)
%plot([1:length(positive_corona_inSystime)],positive_corona_inSystime)
%hold on
%plot([1:length(negative_corona_inSystime)],negative_corona_inSystime)
%plot([1:number_of_pattients],inSysTime,'lineStyle','none','marker','.')
%title('total wait time based ob patients ID')
%xlabel('patient ID') 
%ylabel('wait time')
hist(inSysTime)
title('all patients inSys time histogram')
xlabel('inSys time')
ylabel('count')

figure
hist(positive_corona_inSystime)
title('inSys time for patients with + corona test histogram')
xlabel('inSys time')
ylabel('count')

figure

hist(negative_corona_inSystime)
title('inSys time for patients with + corona test histogram')
xlabel('inSys time')
ylabel('count')
end

