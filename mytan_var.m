function y = mytan_var(varargin)
% function file for y = tan(x) with flexible inputs

% if x is provided as inputs, use x
if nargin == 1
    x = varargin{1};

% if x is NOT provided as inputs, use a default value
else
    x = 0:pi/10:2*pi;
end

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