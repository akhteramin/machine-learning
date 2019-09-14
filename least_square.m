function x=least_square()

traindata = importdata('input_data.txt');
X = traindata(:,1);
Y = traindata(:,2);

N=length(X);
disp(N);

sumX=0;
sumY=0;
%{
sumX=sumX+X(:)'*X(:);
sumXY=sumY+Y(:)'*X(:);
%}
sumX=sum(X.*X);
sumXY=sum(X.*X);

%disp(sumX);
%disp(sumY);
a=sumXY/sumX;
y_pred=a*X;
R=norm(Y-y_pred)^2;
%{
for i=1:N
    R=R+(a*X(i)-Y(i))^2;
end
%}
disp(R)
disp(a)
newA =  0:.1:2;
R = zeros(1,21);
idx = islocalmin(R);

for j=1:21
    c=0;
    for i=1:N
        c=c+(newA(j)*X(i)-Y(i))^2;
    end
    R(j)=c;
    
end



figure(1);
hold on
plot(newA,R);
hold off

figure(2)
plot(X,Y,'*b');
hold on
plot(X,a*X);
hold off
