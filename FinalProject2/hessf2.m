function h=hessf2(x,A,b,c)
    h=A'*diag(1./((b - A*x).^2))*A;
end