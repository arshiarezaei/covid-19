function [] = plot_wait(queue1Wait,queue2Wait,coronaTest)
% 7_2
numberOfPatients = length(coronaTest);
total_wait = zeros(1,numberOfPatients);
positive_patient_wait = [];
negative_patient_wait = [];

for i= 1:numberOfPatients
    if coronaTest(i)== 1
        positive_patient_wait = queue1Wait(i)+queue2Wait(i);
    elseif coronaTest(i)== 0
        negative_patient_wait = queue1Wait(i)+queue2Wait(i);
    end   
end
plot(positive_patient_wait,unique(positive_patient_wait));
hold;
plot(negative_patient_wait,unique(positive_patient_wait));
hold;
plot(total_wait,unique(total_wait));
hold;
legend({'negative patients frequency ','positive patients frequency ', ...
    'total patients frequency '})
end

