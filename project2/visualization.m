clear;
rng(2000);
%visualize function 2

fid = fopen('fun2_A.txt','r');
A = fscanf(fid,'%e ',[500,100]);
fclose(fid);

fid2 = fopen('fun2_b.txt','r');
b = fscanf(fid2,'%e ',[500,1]);
fclose(fid2);

maxX = (A \ b);
xf2 = [];
for j=1:length(maxX)
    xf2 = vertcat(xf2, linspace(maxX(j,:)-10, maxX(j,:)-1));
end
x = linspace(-10, 10);
xf2 = x .* ones(100,1);

yf2 = function2(xf2);

for i=1:1
    %subplot(2,2,i);
    plot(xf2(i,:),yf2);
    title(['Function 2 vs x']);
end

% % visualize function 1
% xrange = linspace(-15,15) .* ones(100,1);
% yrange = zeros(length(xrange),1);
% for i=1:length(xrange)
%     yrange(i) = function1(xrange(:,i));
% end
% 
% for i=1:1
% %     subplot(2,2,i);
%     plot(xrange(i,:),yrange);
%     title(['Function 1 vs X']);
% end

% % visualize function 3
% 
% x = linspace(-10,10);
% xrange = linspace(-10, 10);
% yrange = xrange;
% z = zeros(length(xrange), length(xrange));
% for i=1:length(xrange)
%     for j=1:length(yrange)
%         z(i,j) = function3([xrange(i); yrange(j)]);
%     end
% end
% surf(xrange,yrange,z);
% xlabel('x1');
% ylabel('x2');
% zlabel('f3(x)');
