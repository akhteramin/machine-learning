function x = backsubstitution_v1(A,b)
% A is an upper-triangular matrix
% b is a vector
% want to find x s.t. A*x = b

N = length(A);
disp(N);
x = zeros(N,1);
for i=N:-1:1
    c = 0;
    for j = i+1:N
        c = c + A(i,j)*x(j);
        display(c);
    end
    x(i) = (b(i) - c)/A(i,i);
end