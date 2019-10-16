function [err,pest] = quasinewton_method(f,g,x0,E,N,varagin)


x = x0;
err = [];

if nargin >5
    pstar = varagin(1);
    f0 = f(pstar);
end
 F = eye(length(x0));
for k = 1:N
    x0 = x;
    %change here
    %p = h(x0)\(-g(x0));
    p = -F*g(x);
    a = backtrack_ls(f,g,p,x0);
    x = x0 + a*p;
    
    %newly added for quasi newton
    s = a*p;
    y = g(x) - g(x0);
    F = F + (y'*(F*y + s)/(y'*s)^2)*(s*s') - (s*y'*F + F*y*s')/(y'*s);
        
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
