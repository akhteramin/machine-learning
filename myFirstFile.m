function Yprediction=myFirstFile()

% x = 0:pi/20:2*pi;
traindata=importdata('traindata.txt');
testdata=importdata('testinputs.txt');
% Cross varidation (train: 70%, test: 30%)
cv = cvpartition(size(traindata,1),'HoldOut',0.3);
idx = cv.test;
% Separate to training and test data
dataTrain = traindata(~idx,:);
dataTest  = traindata(idx,:);

x=dataTrain(:,1:8);
y=dataTrain(:,9);
N=length(x);
x=x';
z=[x.^2;x;x.^0];


w=z'\y;


%put this w on remaining test set

Xremain=dataTest(:,1:8);
Xremain=Xremain';
Yremain=dataTest(:,9);
zPred=[Xremain.^2;Xremain;Xremain.^0];
Yprediction= w'*zPred;
Npred=length(Yprediction);
Npred2=length(Yprediction');

Zdiff=(norm(Yremain-Yprediction)^2)/length(dataTest);
 



