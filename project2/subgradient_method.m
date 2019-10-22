function [err,pest] = subgradient_method(f,g,x0,E,N,varagin)

x = x0;
err = [];

if nargin >5 
    pstar = varagin(1);
    f0 = f(pstar);
end

for k = 1:N
    x0 = x;
    p = -g(x0);
    a = .1;
    x = x0 + a*p;
    
    if nargin>5
        err = [err;abs(f(x)-f0)];
    else
        err = [err; abs(f(x)-f(x0))];
    end
    line(vertcat(x0(1),x(1)),vertcat(x0(2),x(2)));
    plot(x(1),x(2),'o');
    if err(k)<= E
        pest = x;
        return;
    end
    pest = x;
end

