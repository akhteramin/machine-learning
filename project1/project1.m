function Rfinal=project1()
%fitlm(X,z)
%model prediction y~1+x2+x3+x4+x5+x8
traindata=importdata('traindata.txt');
testdata=importdata('testinputs.txt');
% Cross varidation (train: 70%, test: 30%)
cv = cvpartition(size(traindata,1),'HoldOut',0.3);
idx = cv.test;
% Separate to training and test data
dataTrain = traindata(~idx,:);
dataTest  = traindata(idx,:);

%dt=array2table(dataTrain, 'VariableNames', {'x1', 'x2','x3','x4','x5', 'x6','x7','x8','y'});
%mdl = stepwiselm(dt,'y ~ x1');

%check data
Xv=dataTrain(:,1:8);
Yv=dataTrain(:,9);

mdl=stepwisefit(Xv,Yv);
disp(mdl);
%check data finish



oneMat=ones(length(dataTrain),1);

z = [oneMat dataTrain(:,1:5) dataTrain(:,8)];
y = dataTrain(:,9);
b=z'*y;
A=z'*z;


w=b\A;

ROneMat=ones(length(dataTest),1);
Xremain=[ROneMat dataTest(:,1:5) dataTest(:,8)];
Yremain=dataTest(:,9);


Yprediction=Xremain*w';

Rfinal=(norm(Yremain-Yprediction)^2)/length(dataTest);

%run on test data buddy
ROneMatTest=ones(length(testdata(:,1)),1);
TrainZ = [ROneMatTest testdata(:,1:5) testdata(:,8)];
 

TrainY=TrainZ*w';




