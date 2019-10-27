function [xstar, f_xstar, err] = optimization_Demo(type_function,type_method,f,g,H,x0,max_iteration,varargin)
subplot(1,2,1);

% Loading A, b, c ...
fun2AData = fopen('fun2_A.txt','r');
A = fscanf(fun2AData,'%e ',[500,100]);
fclose(fun2AData);

fun2BData=importdata('fun2_B.txt');
b=fun2BData(:,:)';

fun2CData=importdata('fun2_C.txt');
c=fun2CData(:,:)';
% finishs loading

if strcmp(type_function,'quadratic') == 1
    [X,Y] = meshgrid(-60:0.1:60);
    Z = X.^2 + 10*(Y.^2);
    contour(X,Y,Z,40);
elseif strcmp(type_function,'exp') == 1
    [X,Y] = meshgrid(-2:0.1:2,-1:0.1:1);
    Z = exp(X + 3.*Y - 0.1) + exp(X - 3.*Y - 0.1) + exp(-X - 0.1);
    contour(X,Y,Z,40);
elseif strcmp(type_function,'exps') == 1
    [X,Y] = meshgrid(-2:0.1:2,-1:0.1:1);
    Z = 10.*(exp(X + 3.*Y - 0.1) + exp(X - 3.*Y - 0.1) + exp(-X - 0.1));
    contour(X,Y,Z,40);
elseif strcmp(type_function,'f2') == 1
    [X,Y] = meshgrid(-3:0.1:3,-1.76:0.1:1);
    Z = zeros(size(X));
    for i = 1:size(X,1)
        for j = 1:size(X,2)
            Z(i,j)= c(1)*X(i,j)+c(2)*Y(i,j)-sum(log(b -A(:,1)*X(i,j)-A(:,2)*Y(i,j)));
        end
    end
    contour(X,Y,Z,40);
elseif strcmp(type_function,'proj3') == 1
    [X,Y] = meshgrid(-5:0.1:5,-60:0.1:60);
    Z = 100.*(Y-X.^2).^2 + (1-X).^2;
    contour(X,Y,Z,40);
    hold on;
    plot(1,1,'or','MarkerSize',10);
    %surf(X,Y,Z);
end



hold on;
plot(x0(1),x0(2),'o');
    
switch type_method
    case 'Gradient'
        [xstar, f_xstar, err] = grad_descent(f,g,x0,max_iteration);
    case 'Quasi'
        [xstar, f_xstar, err] = Quasi(f,g,x0,max_iteration);
    case 'Newton'
        [xstar, f_xstar, err] = Newton(f,g,H,x0,max_iteration);
    case 'LGFBS'
        [xstar, f_xstar, err] = LGFBS(f,g,x0,max_iteration);
    otherwise
        [xstar, f_xstar, err] = grad_descent(f,g,x0,max_iteration);
end    


hold off;


subplot(1,2,2);
plot(err);
xlabel('iteration');

ylabel('f(k) - f(k-1)');
end