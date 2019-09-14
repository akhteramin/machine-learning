function [y,n] = mytanf(x)
% y = tan(x)


n = length(x);
y = zeros(1,n);

for k = 1:n
    if (x(k)~= pi/2) & (x(k)~= 3*pi/2)
        y(k) = tan(x(k));
    else
        y(k) = 0;
    end
end


figure;
plot(x,y,'o');
hold on;
plot(x,y,'k');
xlim([0,max(x)]);
xlabel('x');
ylabel('y');