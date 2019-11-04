function g = p2_gradient(f,x,order,h)
N=length(x);
g=[];
if order==2
    for i=1:N
        e=zeros(N,1);
        e(i)=1;
        %g(i)=
        g(i)=(f(x+h*e)-f(x-h*e))/2*h;
        
    end
else
    for i=1:N
        e=zeros(N);
        e(i)=1;
        g(i)=(f(x+h*e)-f(x))/h;
    end
end


end