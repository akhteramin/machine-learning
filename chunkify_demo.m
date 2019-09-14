function z_test = chunkify_demo()
% we assume N is divisible by K
traindata=importdata('input_data.txt');

x=traindata(:,1);
y=traindata(:,2);
N=length(x);
K=5;
ErrTrain=0;
ErrTest=0;

for k=1:K
    
    test_start = 1+(k-1)*N/K;
    test_end   = k*N/K;
    
    data_test  = x(test_start:test_end,:)';
    y_test = y(test_start:test_end,:);
    
    data_train = [x(1:test_start-1,1)' x(test_end+1:N,1)'];
    y_train = [y(1:test_start-1,1)' y(test_end+1:N,1)'];
    y_train = y_train';
    
    z=[data_train.^2;data_train;data_train.^0];
    w=z'\y_train;
    y_train_pred = w'*z; 
    if ErrTrain==0
        ErrTrain=(norm(y_train_pred'-y_train)^2);
    else
        ErrTrain=[ErrTrain (norm(y_train_pred'-y_train)^2)];
    end
    
    
    z_test=[data_test.^2;data_test;data_test.^0];
    
    y_test_pred = w'*z_test;
    if ErrTest==0
        ErrTest=(norm(y_test_pred'-y_test)^2);
    else
        ErrTest=[ErrTest (norm(y_test_pred'-y_test)^2)];
    end
    

end
figure(1);
bar(ErrTest);
meanTestErr=sum(ErrTest)/length(ErrTest');
yline(meanTestErr,'--','y = 0','LineWidth',3);
title("Test Error");

figure(2);
bar(ErrTrain,'r');
meanTrainErr=sum(ErrTrain)/length(ErrTrain');
yline(meanTrainErr,'--','y = 0','LineWidth',3);
title("Training Error");

fprintf("mean training Error %f \n mean test Error %f",meanTrainErr,meanTestErr)
