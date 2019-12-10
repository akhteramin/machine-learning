function [K] = reconstruct(PC,u,V,K)
%RECONSTRUCT Summary of this function goes here
%   Detailed explanation goes here
    
    reconstruct_image_list = [33]
    fig4 = figure()
    count =1;
    for k_count=10 : 20 : 110
        K = k_count;
        disp(K);
        Unew=PC(:,1:K);
        Vnew=u(:,1:K);
        Snew=V(1:K,1:K);
        Xnew=Unew*Snew*Vnew';
        Xnew=Xnew';
        for l=reconstruct_image_list
            face=reshape(Xnew(l,:),112,92);
            subplot(1,6,count),imshow(face, []);
            title('K =' +" "+ int2str(K) );

        end
        count = count +1;
    end
    saveas(fig4,'K_Increase.fig');
end

