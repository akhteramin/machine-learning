function h=hessf2(x)

fun2AData = fopen('fun2_A.txt','r');
A = fscanf(fun2AData,'%e ',[500,100]);
fclose(fun2AData);
fun2BData=importdata('fun2_B.txt');
b=fun2BData(:,:)';

h=A'*diag(1./((b - A*x).^2))*A;