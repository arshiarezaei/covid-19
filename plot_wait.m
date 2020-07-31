function [] = plot_wait(queue1Wait,queue2Wait,coronaTest)
% 7_2
numberOfPatients = length(coronaTest);
total_wait = queue1Wait + queue2Wait;
positive_patient_wait = [];
negative_patient_wait = [];

for i= 1:numberOfPatients
    disp(i)
    if coronaTest(i)== 1
        disp('this')
        positive_patient_wait = queue1Wait(i)+queue2Wait(i);
        disp(positive_patient_wait)
        disp('pos')
    elseif coronaTest(i)== 0
        disp('neg')
        negative_patient_wait = queue1Wait(i)+queue2Wait(i);
        
    end   
end
plot(1:numberOfPatients,total_wait);
figure
hist(total_wait)
% hold;
% plot(negative_patient_wait,unique(positive_patient_wait));
% hold;
% plot(total_wait,unique(total_wait));
% hold;
% legend({'negative patients frequency ','positive patients frequency ', ...
%     'total patients frequency '})
% disp(total_wait)
% figure
% hist(total_wait);
% 
% legend('total waitt time')
% 
% figure
% hist(positive_patient_wait);
% 
% legend('positive response time')
% figure
% hist(negative_patient_wait);
% 
% legend('negative response time')

end

