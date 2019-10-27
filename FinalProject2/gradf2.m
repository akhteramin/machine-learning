function g=gradf2(x,A,b,c)
    g= c + A'*(1./(b - A*x));
end