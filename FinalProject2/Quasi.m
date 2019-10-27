function [xstar, f_xstar, err] = Quasi(f, g, x, max_iteration, vargin)

if nargin >6 
        tol = vargin(1);
    else
        tol = 0.0001;
    end
    err = [];
    alp = [];
    
%     tic;
    F = eye(length(x));
    for i = 1:max_iteration
        x0 = x;
        f0 = f(x0);
        p = -F*g(x0);
        alpha = bcktrack(f,g,p,x0);
        alp = [alp;alpha];
        x = x0 + alpha*p;
        alpha*p;
        
        err = [err;norm(f(x)-f0)];
        
        %newly added for quasi newton
        s = alpha*p;
        y = g(x) - g(x0);
        F = F + (y'*(F*y + s)/(y'*s)^2)*(s*s') - (s*y'*F + F*y*s')/(y'*s);
        
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
            fprintf('   No convergance in %d iterations, Min of alpha %.20f\n',max_iteration,min(alp))
    end

    % Outputs
    xstar = x;
    f_xstar = f(xstar);
    fprintf('   Error at the end %f\n', err(end))
%     toc;
end