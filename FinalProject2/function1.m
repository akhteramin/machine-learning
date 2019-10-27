function y=function1(x)
    numeric_matrix=[1:length(x)]';
    y=sum((x.^2).*numeric_matrix);
end