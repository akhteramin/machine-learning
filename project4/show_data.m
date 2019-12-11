function [K] = show_data(X)
%SHOW_DATA Summary of this function goes here
%   Detailed explanation goes here
    fig_test = figure()
    for l=1:10
        face=reshape(X(l,:),112,92);
        subplot(2,5,l),imshow(face, []);
        title('Image'+" "+int2str(l))

    end
    saveas(fig_test,'show_test .fig');
    K=0;

end

