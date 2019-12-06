function [val,sigma]=exercise(X)
n=size(X);
Xnew=zeros(n,1);
for i=1:size(X)
    Xnew(i,:)=X(i,:)-mean(X(i,:))
end
Px=(1/n-1)*(Xnew'*Xnew);
