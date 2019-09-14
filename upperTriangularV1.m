function x = upperTriangularV1(A,b)
%Gausian Elimination Algorithm implemented
%mixing up upperTriangular and backsubstitution done in this code
%   Detailed explanation goes here
N = length(A);
for i=1:N-1
    for j=i+1:N
        c=-1*A(j,i)/A(i,i);
        A(j,:)=A(j,:)+(c*A(i,:));
        b(j)=b(j)+(c*b(i));
    end
    disp(A);
    disp(b);
end


x = zeros(N,1);
for i=N:-1:1
    c = 0;
    %{
    for j = i+1:N
        c = c + A(i,j)*x(j);
        display(c);
    end
    %}
    c=c+A(i,i+1:N)*x(i+1:N);
    x(i) = (b(i) - c)/A(i,i);
    disp(x);
end

