function h = estimate_entropy(X)

% entropy if a function of a DISTRIBUTION, not a set of data
% however, this function makes a simple histogram estimate of the 
% distribution, and then calculates the entropy of it.

damin = min(X);
damax = max(X);
bins  = 25;
rez   = (damax-damin)/bins;
hst   = hist(X,damin:rez:damax)/length(X)/rez;
good  = hst>0;
h     = -rez*sum(hst(good).*log(hst(good)));