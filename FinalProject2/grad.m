function drv = grad(f,x,order,h)
    drv = zeros(size(x));
    if order == 1 
        f0 = f(x);
        for i=1:length(drv)
            H = zeros(size(x));
            H(i,:) = h;
            drv(i,:)= (f0-f(x-H));
        end
        drv = drv/h;
    else
        for i=1:length(drv);
            H = zeros(size(x));
            H(i,:) = h;
            drv(i,:)= (f(x+H)-f(x-H))
        end
        drv = drv/(2*h);
    end
end