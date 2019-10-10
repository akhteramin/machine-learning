function alpha=backtrack_ls(f,g,p,x,varargin)
c1=.1;
rho=.5;
if nargin < 5
    alpha = 1;
else
    alpha = varargin{1};
end

while f(x+p*alpha)>f(x)+(c1*alpha*p*g(x)')
    fprintf("p*alpha value %f\n",f(x+p*alpha))
    fprintf("p*alpha+fx %f\n",c1*(p'*g(x)*alpha+f(x)))
    alpha=c1*alpha;
end
