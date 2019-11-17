function Normal(Function_number)

samples = [1 10 100 1000 10000];

mean = [0.01 0.25 0.5 0.75 0.99]; 
sd = [0.1 0.2 0.5 1 2];           

samples_size = length(samples);
mean_size = length(mean);
sd_size = length(sd);

fprintf('The function number from ci.m file is: %2d\n', Function_number);
fid = fopen(['Normal_Function_' int2str(Function_number) '.txt'],'wt');
 
i = 1;
for n = 1: samples_size
    j = 1;
    for s = 1:sd_size
        k = 1;
        for m = 1:mean_size
            hits = 0;
            for iter = 1:10000    
                X = sample_normal(samples(n), sd(s), mean(m));
                mean_test = mean(m);
                [a,b] = ci(X, Function_number);         
                if mean_test >= a && mean_test <= b
                    hits = hits + 1;
                end
            end
            
            fprintf('samples: %5d  Standard Deviation: %1.4f  mean: %1.2f  frac missed: %1.4f\n',samples(n), sd(s), mean(m), 1 - hits/10000);
            fprintf(fid, 'samples: %5d  Standard Deviation: %2.4f  mean: %1.2f  frac missed: %1.4f\n',samples(n), sd(s), mean(m), 1-hits/10000);

            k = k+1;
        end
        j = j+1;
    end
    i = i+1;
end

fclose(fid);

end

