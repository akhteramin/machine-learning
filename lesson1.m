function a = lesson1(varargin)
clear all;
close all;

traindata = importdata('traindata.txt');
x = traindata(1:926,1);
y = traindata(1:926,9);

w=[29.0124;
    0.1020;
    0.0850;
    0.0634;
   -0.2155;
    0.3109;
    0.1151]
a=(sum(x*y')/sum(x*x'));

val=[y w(1,1)+w(2,1)*x+w(3,1)*x.^2];
%R=norm(y-val)^2;
disp(val);
figure(1);
plot(x,y,"*b");
hold on
plot(x,log(a*x),"o");
hold off