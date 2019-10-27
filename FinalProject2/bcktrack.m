function alpha = bcktrack(f, gradf, p, x, varargin)
    % These two variables are important
    c1 = .1;
    rou = .5;
    
    if nargin < 5
        alpha = 1;
    else
        alpha = varargin{1};
    end
    
    while (f(x+alpha*p) > c1*alpha*p'*gradf(x) + f(x)) | imag(f(x+alpha*p))~=0
%         fprintf('f(x+p*alpha) value %f\n',f(x+p*alpha))
%         fprintf('line value %f\n\n',c1*alpha*p'*gradf(x) + f(x))
        alpha = rou*alpha;
    end
    
end
