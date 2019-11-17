function Uniform(Function_number)

samples = [1 10 100 1000 10000];
Lower_Bound = [.1 .1 0 .8 .4 .2];
Upper_Bound = [.2 .9 1 .9 .6 .7];

Low_bound_size = length(Lower_Bound);
samples_size = length(samples);

fprintf('The function number from ci.m file is: %2d\n', Function_number);
fid = fopen(['Uniform_Function_' int2str(Function_number) '.txt'],'wt');

for n = 1:samples_size
    for j = 1:Low_bound_size
        hits = 0;
        lo = Lower_Bound(j);
        up = Upper_Bound(j);
        mu = (lo+up) / 2;
        sigma = (lo-up)^2 / 12;

        for iter = 1:10000
            X = sample_uniform(samples(n), lo, up);
            [a, b] = ci(X, Function_number);
            if a <= mu && b >= mu
                hits = hits + 1;  
            end
        end
        
        fprintf( 'samples: %5d  Standard Deviation: %2.4f  mu: %1.2f  frac missed: %1.4f\n',samples(n), sigma, mu, 1-hits/10000 );
        fprintf(fid, 'samples: %5d  Standard Deviation: %2.4f  mu: %1.2f  frac missed: %1.4f\n',samples(n), sigma, mu, 1-hits/10000);

    end
  
end
      

fclose(fid);
end
