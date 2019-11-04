function [R]= least_square_powerful()

readdata=importdata('input_data.txt');

z=readdata(:,1);

x=readdata(:,1);

y=readdata(:,2);

N=length(y);

xx=z(:,1).^2;

oneMat=ones(N,1);

%for applying quadratic basis expansion
z=[z oneMat xx];

s=sum(y.*z);
% disp(s);
M=z'*z;

% disp(M);

w=s/M;
 disp(w);
y_pred=z*w';
R=norm(y-y_pred)^2;
disp(z);

finalX=z*w';
% finalX=[x finalX];
disp(finalX);


figure(1);
plot(x,y,'*b');
hold on
plot(x, finalX);
hold off

