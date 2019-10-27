function [xstar, f_xstar, err] = grad_descent(f, g, x, max_iteration, vargin)
% veryyy slow, show it in the project
% gradient is very dependent to step size maybe we have a function with
% multiplying only 100 to it, so the nature oesn't change but....   
    if nargin >5 
        tol = vargin(1);
    else
        tol = 0.0001;
    end
    err = [];
    alp = [];
    
%     tic;  
    for i = 1:max_iteration
        x0 = x;
        f0 = f(x0);
        p = -1*g(x0);
        alpha = bcktrack(f,g,p,x0);
        alp = [alp;alpha];
        x = x0 + alpha*p;
        alpha*p;
        
        err = [err;norm(f(x)-f0)];
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