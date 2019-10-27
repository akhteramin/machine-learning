syms x y
z = 100*(y-x^2)^2 + (1-x)^2
ezsurf(z,[-3,3],[-2,4])

z = x^2 + y^2;
figure
ezsurf(z,[-2,2])
