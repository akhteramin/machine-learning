function xk=gradient_descent(f,g,x0,alpha_init,no_of_iteration)

%1. initialize xk and k
xk = x0;
k = 0;

%2. Until x ( k ) is a good enough solution
for i=0:no_of_iteration
    p=-g(xk);
    alpha=backtrack_ls(f,g,p,xk,alpha_init);
    xk=xk+alpha*p;
    
end
