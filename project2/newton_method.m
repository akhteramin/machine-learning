function [err,pest] = newton_method(f,g,h,x0,E,N,varagin)

x = x0;
err = [];

if nargin >6
    pstar = varagin(1);
    f0 = f(pstar);
end

for k = 1:N
    x0 = x;
    p = h(x0)\(-g(x0));
    a = backtrack_ls(f,g,p,x0);
    x = x0 + a*p;
    
    if nargin>6
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
    pause;
end
