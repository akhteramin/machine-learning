function Uniform(Function_number)

samples = [1 10 100 1000 10000];
samples_size = length(samples);

bound = [.1 .1 0 .8 .4 .2;.2 .9 1 .9 .6 .7];
[r,bound_size] = size(bound);
fprintf('The function number from ci.m file is: %2d\n', Function_number);
fid = fopen(['Uniform_Function_' int2str(Function_number) '.txt'],'wt');

for n = 1:samples_size
    for j = 1:bound_size
        hits = 0;
        low = bound(1,j);
        upper = bound(2,j);
        mu = (low+upper) / 2;
        sigma = (upper-low)^2 / 12;

        for iter = 1:10000
            X = sample_uniform(samples(n), low, upper);
            [a, b] = ci(X, Function_number);
            if a <= mu && b >= mu
                hits = hits + 1;  
            end
        end
        
        fprintf( 'samples: %5d  Std: %2.4f [up,low]:[%f,%f] mu: %1.2f  frac missed: %1.4f\n',samples(n), sigma,bound(1,j),bound(2,j),mu, 1-hits/10000 );
        fprintf(fid, 'samples: %5d  Std: %2.4f [up,low]:[%f,%f]  mu: %1.2f  frac missed: %1.4f\n',samples(n), sigma,bound(1,j),bound(2,j)  ,mu, 1-hits/10000);

    end
  
end
      

fclose(fid);
end
