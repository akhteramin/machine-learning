function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C=0;
sigma=0;
Cval = [0.01 0.03 0.1 0.3 1 3 10 30];
CvalSize=length(Cval);
sigmaval = [0.01 0.03 0.1 0.3 1 3 10 30];
sigmavalSize=length(sigmaval);
% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
minVal=1000;
for i=1:CvalSize
    for j=1:sigmavalSize
        model=svmTrain(X,y,Cval(i),@(x1,x2)gaussianKernel(x1,x2,sigmaval(j)));

        predictions = svmPredict(model, Xval);
        if(minVal>mean(double(predictions ~= yval)))
            minVal=mean(double(predictions ~= yval));
            C=Cval(i);
            sigma=sigmaval(j);
        end
    end
    
end
% =========================================================================
disp("C sigma")
disp(C)
disp(sigma)
end
