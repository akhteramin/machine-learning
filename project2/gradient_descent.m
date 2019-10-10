function xk=gradient_descent(f,g,x0,alpha_init,f_tol,varargin)

if nargin < 6
    no_of_iteration = 1000;
else
    no_of_iteration = varargin{1};
end
%1. initialize xk and k
xk = x0;
k = 0;

%2. Until x ( k ) is a good enough solution

i=0;
alpha=alpha_init;
p=-g(xk);
disp(p);
%3. diff tolerance and number of iteration tracking
while i<no_of_iteration && abs(norm(alpha*p))>f_tol
    i=i+1;
    p=-g(xk);
    alpha=backtrack_ls(f,g,p,xk,alpha);
    xk=xk+alpha*p;
    
end
