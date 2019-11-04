function [a,b,R]=least_square_bias()

readdata=importdata('input_data.txt');
X=readdata(:,1);
Y=readdata(:,2);
N=length(X);


meanX=mean(X);

meanY=mean(Y);


meanXY=mean(X.*Y);


meanXX=mean(X.*X);



b=(meanY-((meanX*meanXY)/meanXX))/(1-((meanX^2/(meanXX))));

a=(meanY-b)/meanX;

R=0;
for i=1:N
    R=R+(a*X(i)+b-Y(i))^2;
end
disp(a);
disp(b);
disp(R);

figure(1);
plot(X,Y,'*b');
hold on
plot(X,a*X+b);
hold off



