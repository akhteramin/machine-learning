function hess = p2_hessian(f,x,order,hs)
N=length(x);
hess=zeros(1,N);
g1=[];
g2=[];
    if order==1
        for i=1:N
            e=zeros(N,1);
            e(i)=1;
            
            for j=1:N    
                g1(j)=(f(x+hs*e(i))-f(x-hs*e(i)))/2*hs;
                g2(j)=(f(x+hs*e(j)+hs*e(i))-f(x+hs*e(j)-hs*e(i)))/hs;
                h(i,j)=(g2(j)-g1(j))/hs;
            end
            
           
        end
    end
    if order==2
        for i=1:N
            e=zeros(N,1);
            e(i)=1;
            for j=1:N                                
                g1(j)=(f(x-hs*e(j)+hs*e(i))-f(x-hs*e(j)-hs*e(i)))/2*hs;
                g2(j)=(f(x+hs*e(j)+hs*e(i))-f(x+hs*e(j)-hs*e(i)))/2*hs;
                hess(i,j)=(g2(j)-g1(j))/hs;
            end
           
        end
    end
end

