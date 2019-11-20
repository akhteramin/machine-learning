function Bernoulli(Function_number)

samples = [1 10 100 1000 10000];
samples_size = length(samples);

theta = [.01 .1 .25 .5 .75 .99];
theta_size = length(theta);

fprintf('The function number from ci.m file is: %2d\n', Function_number);
fid = fopen(['Bernoulli_Function_' int2str(Function_number) '.txt'],'wt');

for n = 1: samples_size
    j = 1;
    for t = 1: theta_size
        hits = 0;
        mu = theta(t);
        sigma = theta(t) * (1-theta(t));
        
        for i = 1:10000  
            X = sample_bernoulli(samples(n), theta(t));
            [a,b] = ci(X, Function_number);  
            if a <= mu && b >= mu
                hits = hits + 1;
            end
        end

        fprintf('samples: %5d  Var: %2.3f  Mean: %2.3f  frac missed: %2.3f\n', samples(n), sigma, mu, 1-hits/10000);
        fprintf(fid, 'samples: %5d  Standard Deviation: %2.3f  mu: %2.3f  frac missed: %2.3f\n',samples(n), sigma, mu, 1-hits/10000);

        j = j+1;
    end
    
   
end
     
end
