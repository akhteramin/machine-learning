function val=hoeffding_ci_asymptotic_test()
    for alpha = [.05 .25]
        if alpha==.05
            ep0 = 1.95996;
        elseif alpha==.25
            ep0 = 1.15034;
        else
        error("no value for this alpha");
        end
        for N=[10 100 1000 10000]
            hits = 0;
            mean_ep = 0;
            for reps=1:10000
                p = .5;
                X = sample_bernoulli(N,p);
                Xbar = mean(X);
                sig = std(X);
                ep = sig*ep0/sqrt(N);
                mean_ep = mean_ep + ep/10000;
                if abs(Xbar - p) <= ep
                    hits = hits + 1;
                end
            end
            fprintf("alpha: %1.3f N: %5d ep: %1.3f frac missed: %1.3f\n",alpha, N, mean_ep, 1-hits/10000);
        end
    end