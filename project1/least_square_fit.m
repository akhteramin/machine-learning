function val=least_square_fit()
z=[.1 .2 .3 .4;.5 .6 .7 .7];
y=[.9,1,1.1,1.2];

b=z*y';
A=z*z';
%{
N = length(A);
for i=1:N-1
    for j=i+1:N
        c=-1*A(j,i)/A(i,i);
        A(j,:)=A(j,:)+(c*A(i,:));
        b(j)=b(j)+(c*b(i));
    end
end


x = zeros(N,1);
for i=N:-1:1
    c = 0;
    c=c+A(i,i+1:N)*x(i+1:N);
    x(i) = (b(i) - c)/A(i,i);
end
%}

w=A\b;
val=w'*z;
disp(val);
disp(y);
R=norm(y-val)^2;
