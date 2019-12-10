function [] = Variable_Eigen()
    tol=[.25,.5,.6,.75,.8,.81,.82,.83,.85,.86,.9,.91,.92,.93,.94,.95,.99]
    for i=1:length(tol)
        [img, label,PC,Ktol] = eigen("svd",tol(i),1);
    end
end

