function [err,pest] = lbfgs_method(f,g,x0,E,N,varagin)


x = x0;
m=10;
err = [];

if nargin >5
    pstar = varagin(1);
    f0 = f(pstar);
end
 F = eye(length(x0));
 p = -F*g(x);
for k = 1:N
    x0 = x;
    %change here
    %p = h(x0)\(-g(x0));
    
    a = backtrack_ls(f,g,p,x0);
    x = x0 + a*p;
    
    %newly added for quasi newton
    s = a*p;
    y = g(x) - g(x0);
    
    %start two loop recursion
    q=-g(x);
    disp(dot(s(:,1),q));
    rho=1./(y'*s);
    for i=m-1:-1:1
        alpha(i)=rho(i)*dot(s(:,i),q);
        q=q-alpha(i)*y(:,i);
    end
    
    for i=1:m-1
        B=rho(i)*y(:,i)'*p;
        p=p+s(:,i)*(alpha(i)-B);
    end
    
    %finish two loop recursion
    
    % F = F + (y'*(F*y + s)/(y'*s)^2)*(s*s') - (s*y'*F + F*y*s')/(y'*s);
        
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
