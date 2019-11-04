function y = mytanv(x)
% function for y=tan(x) with vectorized operation

n = length(x);
y = zeros(1,n);

%%version 1: indexing by finding the index of the elements that satisfy a
%%certain criteria
% ind = find((x~= pi/2) & (x~= 3*pi/2));
% y(ind) = tan(x(ind));
% ind = find(~(x~= pi/2) & (x~= 3*pi/2));
% y(ind) = 0;


%%version 2: indexing by logical array

ind = (x~=pi/2 & x~=(3*pi)/2);
y(ind) = tan(x(ind));
y(~ind) = 0;



figure;
plot(x,y,'o');
hold on;
plot(x,y,'k');
xlim([0,max(x)]);
xlabel('x');
ylabel('y');