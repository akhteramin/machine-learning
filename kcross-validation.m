function w=polynomial_function()

% x = 0:pi/20:2*pi;

traindata=importdata('input_data.txt');
x=traindata(:,1);
y=traindata(:,2);
N=length(x);
x=x';
% kth data remove from training data z(:,((k-1)N/k)+1:k(N/k))