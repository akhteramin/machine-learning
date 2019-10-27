function [xstar, f_xstar, err] = LGFBS(f, g, x, max_iteration, vargin)

if nargin >6 
        tol = vargin(1);
    else
        tol = 0.0001;
    end
    err = [];
    alp = [];
    m=5;
    
%     tic;
    F = eye(length(x));
    p = -F*g(x);
    for i = 1:max_iteration
        x0 = x;
        f0 = f(x0);
        
        alpha = bcktrack(f,g,p,x0);
        alp = [alp;alpha];
        x = x0 + alpha*p;
        alpha*p;
        
        err = [err;norm(f(x)-f0)];
        
        %newly added for quasi newton
        s = alpha*p;
        y = g(x) - g(x0);
        
        %start two loop recursion
        q=g(x);
    
        for j=m-1:-1:1
            alpha2=(s'*q)/(y'*s);
            q=q-alpha2*y;
        end
        gama=(s'*y)/(y'*y);
        F=gama*eye(length(x0));
        p=F*q;
        for k=1:m-1
            B=y'*p/(y'*s);
            p=p+s*(alpha2-B);
        end
        p=-p;
        %finish two loop recursion
        
        % Checking the convergance
        if err(end) <= tol
            break;
        end
        
        % Plot
        line(vertcat(x0(1),x(1)),vertcat(x0(2),x(2)));
        plot(x(1),x(2),'o');
        
%         pause;
    end
    
    fprintf('Number of steps is %d\n', i)
    if i== max_iteration | min(alp)<1e-10
            fprintf('   No convergance in %d iterations, Min of alpha %.20f\n',i,min(alp))
    end
    
    % Outputs
    xstar = x;
    f_xstar = f(xstar);
    fprintf('   Error at the end %f\n', err(end))
%     toc;
end