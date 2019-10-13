function [err,pest] = optimization_Demo(type_function,type_method,f,g,H,x0,N,E,varargin)

subplot(1,2,1);

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
elseif strcmp(type_function,'proj3') == 1
    [X,Y] = meshgrid(-2:0.1:2,-2:0.1:2);
    Z = 100.*(Y-X.^2).^2 + (1-X).^2;
    contour(X,Y,Z,40);
    hold on;
    plot(1,1,'or','MarkerSize',10);
    %surf(X,Y,Z);
end



hold on;
plot(x0(1),x0(2),'o');

if nargin>8
    pstar = varargin{1};
    plot(pstar(1),pstar(2),'*');
    switch type_method
        case 'Gradient'
            [err,pest] = gradient_descent(f,g,x0,E,N, pstar);
        case 'GradientS'
            [err,pest] = gradientDescentS(f,g,x0,N,E, pstar);
        case 'Newton'
            [err,pest] = newton_method(f,g,H,x0,E,N,pstar);
        otherwise
            [err,pest] = Q_Newton(f,g,x0,N,E,pstar);
    end
            
else
    switch type_method
        case 'Gradient'
            [err,pest] = gradient_descent(f,g,x0,E,N);
        case 'GradientS'
            [err,pest] = gradientDescentS(f,g,x0,N,E);
        case 'Newton'
            [err,pest] = newton_method(f,g,H,x0,E,N);
        otherwise
            [err,pest] = Q_Newton(f,g,x0,N,E);
    end    
end

plot(pest(1),pest(2),'ro');
%plot3(pest(1),pest(2),f(pest),'ro');

hold off;

if nargin>8
    err0 = abs(f(x0) - f(pstar));
    err = vertcat(err0,err);
end

subplot(1,2,2);
plot(err);
xlabel('iteration');

if nargin>8
    ylabel('f-p*');
else
    ylabel('f(k) - f(k-1)');
end