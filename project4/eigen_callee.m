function [PC,Ktol] = eigen_callee(tol,show,image)
    label=[]
    % 
    % rootpath="./att_faces";
    % [image]=total_mat(rootpath);
    X=zeros(size(image,1),92*112);
    disp(size(image));
    for i=1:size(image,1)
        meanX=mean(image(i,:));
        X(i,:)=image(i,:)-meanX;
    end
    X=X';
    image = image';
    disp(size(image))
    N=size(X,2);
    PC=[];Ktol=0;
    U=[];S=[];V=[];
        X=X/sqrt(N);
        [PC,V,u] = svd(X);

        g=(V*V');
        totalVariance=sum(sum(g));
        sumSigma=zeros(length(V),1);
        sumS=0;
        K=0;
        for k=1:length(g)
            sumSigma(k)=sum(g(k,:));
            sumS=sumS+sumSigma(k);
            sumSigma(k)=sumS/totalVariance;
            if sumS/totalVariance>=tol && K==0
                K=k;
                Ktol=K;
            end
        end
        if show==0
            return
        end
        plot(sumSigma,"o")
        xlabel("total variance"+int2str(totalVariance)+" "+int2str(V(1,1)))
        xlim([0 1000])
        ylim([0 1])

        %%%%%%%% Reconstruction%%%%%%%%%%

        Unew=PC(:,1:K);
        disp(K);
        Vnew=u(:,1:K);
        Snew=V(1:K,1:K);
        Xnew=Unew*Snew*Vnew';
        Xnew=Xnew';
        fig_show = figure()
        for l=1:5
            face=reshape(Xnew(l,:),112,92);
            subplot(1,5,l),imshow(face, []);
            title('Face'+" "+int2str(l))

        end
        saveas(fig_show,'train_reconstruct.fig');
    %%%%%%%%%%%%%%%%%% eigen.%%%%%%%%%%%%%%%%%%


    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Select and Build Test Images & Labels%%%%%%%%%%%%%%%%
% 
% function [testImage,label] = readyTestImage(images)
%     [Mp,Np]=size(images);
%     testImage=zeros(120,Np);
%     label=zeros(120,1);
%     disp(size(images));
%     disp(size(testImage));
%     j=1;
%     for i=1:400
%         if i<=350 && (rem(i,10)==9 || rem(i,10)==0)
%             testImage(j,:)=images(i,:);
%             if rem(i,10)~=0
%                 label(j)=floor(i/10)+1;
%             else
%                 label(j)=floor(i/10);
%             end
%             j=j+1;
%         
%         elseif i>350
%             testImage(j,:)=images(i,:);
%             if rem(i,10)~=0
%                 label(j)=floor(i/10)+1;
%             else
%                 label(j)=floor(i/10);
%             end
%             j=j+1;
%             
%         end
%         
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Convert raw images to dataset%%%%%%%%%%%%%%%%
% 
% function [ t_mat ] = total_mat( root_path)
% totalsub=40;
% impersub=10;
% N = totalsub*impersub;
% M = 92*112;
% t_mat = zeros(M,N);
% msg = '';
%     for s=1:totalsub
%         for i=1:impersub
%             nextPath = strcat(root_path, '/s', int2str(s), '/', int2str(i), '.pgm');
%             if exist(nextPath, 'file') 
%                 nextImage = imread(nextPath, 'PGM');
%                     t_mat(:,(s-1)*impersub+i) = nextImage ( : );
%             else
%                 disp(strcat(msg,'image [', nextPath,'] does not exist.\n'));
%             end
%         end
%     end
%     
% 
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Select and Build Train Images & Labels%%%%%%%%%%%%%%%%
% 
% function [trainImage,trainlabel] = readyTrainImage(images)
%     [Mp,Np]=size(images);
%     
%     trainImage=zeros(280,Np);
%     j=1;
%     for i=1:400
%         if rem(i,10)~=9 && rem(i,10)~=0 && i<350
%             trainImage(j,:)=images(i,:);
%             
%             j=j+1;
%         end
%         
%     end
%     writematrix(trainImage,"X_tab.txt",'Delimiter','tab');
%     type 'X_tab.txt';
%     
%    trainlabel = zeros(280,1);
%    for i=1:280
%        if rem(i,8)~=0
%            trainlabel(i)=floor(i/8)+1;
%        else
%            trainlabel(i)=floor(i/8);
%        end
%    end
%     
% end
