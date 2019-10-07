function g=gradf2(x)

fun2AData = fopen('fun2_A.txt','r');
A = fscanf(fun2AData,'%e ',[500,100]);
fclose(fun2AData);
fun2BData=importdata('fun2_B.txt');
b=fun2BData(:,:)';
fun2CData=importdata('fun2_C.txt');
c=fun2CData(:,:)';

g= c + A'*(1./(b - A*x))