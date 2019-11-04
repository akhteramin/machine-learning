X = categorical({'Agree','Not Agree','Confused'});
X = reordercats(X,{'Agree','Not Agree','Confused'});
Y = [7 6 9 7 9;3 2 3 2 4;3 4 1 4 0];
title("User Response in Result 1,2,3")
bar(X,Y,'stacked')