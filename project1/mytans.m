% script for y = tan(x)

x =  0:pi/45:2*pi; %linspace(0,2*pi,100)
n = length(x);
y = zeros(1,n);

for k = 1:n
    if (x(k)~= pi/2) & (x(k)~= 3*pi/2)
        y(k) = tan(x(k));
    else
        y(k) = 1;
    end
end


figure;
plot(x,y,'o');
hold on;
plot(x,y,'k');
xlim([0,max(x)]);
xlabel('x');
ylabel('y');