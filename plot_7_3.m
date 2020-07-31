function [] = plot_7_3(queue1Arrive,exitTime,coronaTest)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
simulation_length = max(exitTime);
number_of_patientss = length(queue1Arrive);
in_sys_frequency = zeros(simulation_length,2);
positive_in_sys_frequency = zeros(simulation_length,2);
negative_in_sys_frequency = zeros(simulation_length,2);
   

for i = 1:simulation_length
    in_sys_frequency(i,1)=i;
    positive_in_sys_frequency(i,1)=i;
    negative_in_sys_frequency(i,1)=i;
    for j= 1:number_of_patientss
        if queue1Arrive(j)<=i && exitTime(j) >= i 
            in_sys_frequency(i,2)=in_sys_frequency(i,2)+1;
            if coronaTest(j)==1
                positive_in_sys_frequency(i,2)=positive_in_sys_frequency(i,2)+1;
            elseif coronaTest(j)==0
                negative_in_sys_frequency(i,2)=negative_in_sys_frequency(i,2)+1;
            end
            
        end
          
    end
end

plot(in_sys_frequency(:,1),in_sys_frequency(:,2))
title('total number of patients in system during simulation')
xlabel('simulation time')
ylabel('number of patinets in system')
figure
plot(positive_in_sys_frequency(:,1),positive_in_sys_frequency(:,2))
title('number of positive patients in system during simulation')
xlabel('simulation time')
ylabel('number of patinets in system')
figure
plot(negative_in_sys_frequency(:,1),negative_in_sys_frequency(:,2))
title('number of negative patients in system during simulation')
xlabel('simulation time')
ylabel('number of patinets in system')
end

