y=[];
variance=[];
for N=1:10
    for i=1:10000
        sample=sample_uniform(N,-sqrt(3),sqrt(3));
        y=[y;(1/sqrt(10))*sum(sample)];  
        %variance=[variance;(1/(length(y)-1))*(y-mean(y)).^2];

    end
    disp(mean(y));
    disp(var(y));
    disp(estimate_entropy(y));
    hist(y);
end