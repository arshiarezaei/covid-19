clc
clear all

fid = fopen('simulation_parameters.txt');
basicParameters = str2num(fgetl(fid));
numberOfRoom = basicParameters(1);
landa = basicParameters(2); % Patient Arrive Rate
alfa = basicParameters(3); % Patient Tiredness Rate
receptionRate = basicParameters(4); % Reception Service Rate

numberOfPatient = 10000; 
tline = fgetl(fid);
doctorCuringRate = cell(numberOfRoom,1);
for i=[1:numberOfRoom]
    if ischar(tline)
        doctorCuringRate(i,1) =  {str2num(tline)};
    
    else
        break;
    end
    tline = fgetl(fid)
end

% to mehrdad: replace doctor rate with doctor curring rate 
M = numberOfRoom;
m = 3;
numberOfDoctor = 3; % In Each Room 
doctorRate = 3*ones(M,m); % Doctor Curing Rate

queue1NumberOfPatients = zeros(1,numberOfPatient); % Number Of Patients In Reception Queue Everytime
queue1InterArrival = exprnd(landa,1,numberOfPatient); % InterArrival To The Hospital
queue1Arrive = zeros(1,numberOfPatient); % Arrive Time To The Hospital

queue1Positive = queue_array(); % A Queue For + Corona Patients
queue1Negative = queue_array(); % A Queue For - Corona Patients

% Computing The Arrive Time To Hospital
queue1Arrive(1) = 1; 
for i = 1:numberOfPatient
    queue1InterArrival(i) = fix(queue1InterArrival(i))+1;
end
for i = 2:numberOfPatient
    queue1Arrive(i) = queue1Arrive(i-1) + queue1InterArrival(i);
end
%/

% Finding The Corona + Patients
coronaTest = zeros(1,numberOfPatient);
numberOfCoronaPositive = numberOfPatient*rand(1,numberOfPatient/10);
for i = 1:numberOfPatient/10
    coronaTest(fix(numberOfCoronaPositive(i))+1) = 1;
end
%/

% Computing The Service Time For Each Patient
serviceTime = exprnd(receptionRate,1,numberOfPatient);
for i = 1:numberOfPatient
    serviceTime(i) = fix(serviceTime(i)) + 2;
end
%/

queue2Arrive = -1*ones(1,numberOfPatient); % Arrive Time To Rooms Queue

queue1Wait = zeros(1,numberOfPatient); % Waited Time In Queue1 For Each Patient
queue2Wait = zeros(1,numberOfPatient); % Waited Time In Queue2 For Each Patient

queue2Positive(1,M) = queue_array(); % A Queue For + Corona Patients In Doctors Room Queue
queue2Negative(1,M) = queue_array(); % A Queue For - Corona Patients In Doctors Room Queue

doctorRoomArrive = -1*ones(1,numberOfPatient); % Arrive Time To The Doctors Room
exitTime = zeros(1,numberOfPatient); 
doctorRoomNumber = zeros(2,numberOfPatient); % Doctor Number Of Each Patient
queue2NumberOfPatient = zeros(1,M); % Number Of Patients In Doctors Room Queue Everytime

% Computing The First Patient
if(coronaTest(1) == 1)
    push(queue1Positive,1);
    lastPositivePatientNumber = 1;
    lastNegativePatientNumber = 0;
else
    push(queue1Negative,1);
    lastNegativePatientNumber = 1;
    lastPositivePatientNumber = 0;
end
%/ 

Counter = 0;
time1 = 0; % A Variable That Changes For Each Patient From Service Time To Zero 
time2 = zeros(M,m); % A Variable That Changes For Each Patient From Doctor Curing To Zero
reception = 1; % Number(ID) Of Patient That Work With Reception Everytime
doctor = zeros(M,m); % Number(ID) Of Patient That Work With Each Doctor Everytime
F1 = 1;
F2 = 0;
queue1Lentgh = 0; % Everytime
queue2Lentgh = zeros(1,M); % Everytime

%%
 assigned_doctor = cell(numberOfRoom,1);
 for i=[1:numberOfRoom]
     len = length(doctorCuringRate{i,1});
      assigned_doctor{i,1} = repelem(0,len);
 end
%%

for t = 1:100*numberOfPatient
    
    %Computing lentgh of queues
    queue1Lentgh = queue1Lentgh + size(queue1Positive) + size(queue1Negative);
    for i = 1:numberOfRoom
        queue2Lentgh(i) = queue2Lentgh(i) + queue2NumberOfPatient(i);
    end
    %/
    
    %Inter to Queue1
    if(lastPositivePatientNumber < numberOfPatient && lastNegativePatientNumber < numberOfPatient)
        C1 = max(lastPositivePatientNumber,lastNegativePatientNumber)+1;
        if(t == queue1Arrive(C1))   
            if(coronaTest(C1) == 1)
                push(queue1Positive,C1);
                lastPositivePatientNumber = C1;
            else
                push(queue1Negative,C1);
                lastNegativePatientNumber = C1;
            end  
        end
    end
    
    % Checking Tiredness 1
    %S1 = size(Q1_Pos); 
    %for h = 1:S1
     %   if((t - Q1_Arrive(front(Q1_Pos))) >= alfa )
      %      Exit(front(Q1_Pos)) = t;
       %     Counter = Counter + 1;
        %    Wait1(front(Q1_Pos)) = t - Q1_Arrive(front(Q1_Pos));
         %   pop(Q1_Pos);
        %else
         %   break;
       % end
    %end
    
    S2 = size(queue1Negative);
    for h = 1:S2
        if((t - queue1Arrive(front(queue1Negative))) >= alfa )
            exitTime(front(queue1Negative)) = t;
            Counter = Counter + 1;
            queue1Wait(front(queue1Negative)) = t - queue1Arrive(front(queue1Negative));
            pop(queue1Negative);
        else
            break;
        end
    end
    %/
    
    %Inter From Queue1 to Reception 
    if(time1 == 0)
        if(empty(queue1Positive) == 0)
            reception = front(queue1Positive);
            pop(queue1Positive);
            time1 = serviceTime(reception) + t ;
            queue1Wait(reception) = t - queue1Arrive(reception);
        elseif(empty(queue1Negative) == 0)
            reception = front(queue1Negative);
            pop(queue1Negative);
            time1 = serviceTime(reception) + t ;
            queue1Wait(reception) = t - queue1Arrive(reception);
        end
            F1 = 0;
    else
        if(time1 == t)
            time1 = 0;
            C2 = reception;
            F1 = 1; % That Means A Patient Gone To The Doctor Rooms Queue
            queue2Arrive(C2) = t + 1;
        else
            F1 = 0;
        end
      
    end
    %/
    
    % Inter From Reception to Queue2 
    if(F2 == 1)
        Index = Pos_Min(queue2NumberOfPatient, M);
        
        if(coronaTest(C2) == 1)
            push(queue2Positive(Index),C2);
            queue1NumberOfPatients(C2) = Index;
        else
            push(queue2Negative(Index),C2);
            queue1NumberOfPatients(C2) = Index;
        end
        
        queue2NumberOfPatient(Index) = queue2NumberOfPatient(Index) + 1;
        
        F2 = 0;
    end
    if(F1 == 1)
        F2 = 1; % That Means In The Next (t) A Patient Arrives To Queue
        F1 = 0;
    end
    %/
    
    % Checking Tiredness 2
    for k = 1:numberOfRoom
        
        %S1 = size(Q2_Pos(k));
        %for h = 1:S1
         %   if((t - Q2_Arrive(front(Q2_Pos(k))) + Wait1(front(Q2_Pos(k)))) >= alfa )
          %      Exit(front(Q2_Pos(k))) = t;
           %     Counter = Counter + 1;
            %    Wait2(front(Q2_Pos(k))) = t - Q2_Arrive(front(Q2_Pos(k)));
             %   pop(Q2_Pos(k));
            %else
             %   break;
            %end
        %end
        
        S2 = size(queue2Negative(k));
        for h = 1:S2
            if((t - queue2Arrive(front(queue2Negative(k))) + queue1Wait(front(queue2Negative(k)))) >= alfa )
                exitTime(front(queue2Negative(k))) = t;
                Counter = Counter + 1;
                queue2Wait(front(queue2Negative(k))) = t - queue2Arrive(front(queue2Negative(k)));
                pop(queue2Negative(k));
            else
                break;
            end
        end
    
    end
    %/
    
    %Inter From Queue2 to Doctor
    for i = 1:numberOfRoom
        for j = 1:numberOfDoctor
            if(time2(i,j) == 0)
                if(empty(queue2Positive(i)) == 0)
                    doctor(i,j) = front(queue2Positive(i));
                    pop(queue2Positive(i));
                
                    time2(i,j) = fix(exprnd(Doctor_Rate(i,j)))+1;
                    doctorRoomArrive(doctor(i,j)) = t;
                    doctorRoomNumber(1,doctor(i,j)) = i;
                    doctorRoomNumber(2,doctor(i,j)) = j;
                    if(t > queue2Arrive(doctor(i,j)))
                        doctorRoomArrive(doctor(i,j)) = doctorRoomArrive(doctor(i,j)) - 1;
                    end    
                    queue2Wait(doctor(i,j)) = doctorRoomArrive(doctor(i,j)) - queue2Arrive(doctor(i,j));
                
                elseif(empty(queue2Negative(i)) == 0)
                    doctor(i,j) = front(queue2Negative(i));
                    pop(queue2Negative(i));
                
                    time2(i,j) = fix(exprnd(Doctor_Rate(i,j)))+1;
                    doctorRoomArrive(doctor(i,j)) = t;
                
                    doctorRoomNumber(1,doctor(i,j)) = i;
                    doctorRoomNumber(2,doctor(i,j)) = j;
                    if(t > queue2Arrive(doctor(i,j)))
                        doctorRoomArrive(doctor(i,j)) = doctorRoomArrive(doctor(i,j)) - 1;
                    end    
                    queue2Wait(doctor(i,j)) = doctorRoomArrive(doctor(i,j)) - queue2Arrive(doctor(i,j));
                
                end
            else
                if(time2(i,j) == 1)
                    time2(i,j) = 0;
                    exitTime(doctor(i,j)) = t ;
                    if(~queue2Wait(doctor(i,j)) == 0)
                        exitTime(doctor(i,j)) = t - 1;
                    end
                
                    queue2NumberOfPatient(i) = queue2NumberOfPatient(i) - 1;
                    Counter = Counter + 1;
                else
                    time2(i,j) = time2(i,j) - 1;
                end
            end
        end
    end
    %/
    
    %Level 5 Inter From Doctor to Out
    %for i = 1:M
     %  for j = 1:m
      %     if(F4(i,j) == 1)
       %        Counter = Counter + 1;
        %       
         %      F4(i,j) = 0;
          % end
           %if(F3(i,j) == 1)
            %   F4(i,j) = 1;
             %  F3(i,j) = 0;
           %end
       %end
    %end
     
    %End Condition
    if(Counter == numberOfPatient)
         break;
    end
    %/
    t = t + 1;
end


disp('Simulation Time');
disp(t);


disp('Average Spended time in System for all Patients');
S = 0;
for i = 1:numberOfPatient
    S = S + exitTime(i) - Q1_Arrive(i);
end
D = S/numberOfPatient;
disp(D);

    
disp('Average Spended time in System for + Corona Patients');
S = 0;
for i = 1:numberOfPatient
    if(coronaTest(i) == 1)
        S = S + exitTime(i) - Q1_Arrive(i);
    end
end
D = (S*10)/numberOfPatient;
disp(D);

    
disp('Average Spended time in System for - Corona Patients');
S = 0;
for i = 1:numberOfPatient
    if(~coronaTest(i) == 1)
        S = S + exitTime(i) - Q1_Arrive(i);
    end
end
D = (S*10)/(numberOfPatient*9);
disp(D);


disp('Average Spended time in Queues for all Patients');
S = 0;
for i = 1:numberOfPatient
    S = S + queue1Wait(i) + queue2Wait(i);
end
D = S/numberOfPatient;
disp(D);

    
disp('Average Spended time in Queues for + Corona Patients');
S = 0;
for i = 1:numberOfPatient
    if(coronaTest(i) == 1)
        S = S + queue1Wait(i) + queue2Wait(i);
    end
end
D = (S*10)/numberOfPatient;
disp(D);

    
disp('Average Spended time in Queue for - Corona Patients');
S = 0;
for i = 1:numberOfPatient
    if(~coronaTest(i) == 1)
        S = S + queue1Wait(i) + queue2Wait(i);
    end
end
D = (S*10)/(numberOfPatient*9);
disp(D);


disp('Number of Exhausted Patients');
S = 0;
for i = 1:numberOfPatient
    if(doctorRoomArrive(i) == -1)
        S = S + 1;
    end
end
disp(S);
 

disp('Average Lentgh of Reception Queue');
queue1Lentgh = queue1Lentgh/t;
disp(queue1Lentgh);
 

disp('Average Lentgh of Doctors room Queue');
for i = 1:numberOfRoom
    queue2Lentgh(i) = queue2Lentgh(i)/t;
end
disp(queue2Lentgh);
        

disp(Counter);
 
