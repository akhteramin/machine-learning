function [] = Variable_Eigen()
    tol=[.25,.5,.6,.75,.8,.9,.95,.99]
    for i=1:length(tol)
        [img, label,PC,Ktol] = eigen("svd",tol(i),1);
    end
end

