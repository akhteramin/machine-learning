function [image,label,PC,Ktol] = eigen(typ,tol,show)
label=[]

rootpath="./att_faces";
[image]=total_mat(rootpath);
image=image';
X=zeros(400,92*112);
disp(size(image));
for i=1:400
    meanX=mean(image(i,:));
    X(i,:)=image(i,:)-meanX;
end
X=X';
image = image';
disp(size(image))
N=size(X,2);
PC=[];Ktol=0;
U=[];S=[];V=[];
if strcmp(typ,"svd")
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
    
    Unew=PC(:,1:K);
    disp(K);
    Vnew=u(:,1:K);
    Snew=V(1:K,1:K);
    Xnew=Unew*Snew*Vnew';
    Xnew=Xnew';

    for l=1:5
        face=reshape(Xnew(l,:),112,92);
        figure()
        imshow(face, []);
        title('Face'+" "+int2str(K))

    end
%%%%%%%%%%%%%%%%%% Modify and fix eigen.%%%%%%%%%%%%%%%%%%
else
    [D,V]=eig((X*X')./N-1);
    [D,idx]=sort(sort(D,1,'descend'),2,'descend');
    D=diag(D(1,:));
    
    PC = D;
    
    totalVariance=sum(sum(D));
    sumSigma=zeros(10304,1)
    sumS=0;
    K=0;
    for k=1:10304
        sumSigma(k)=sum(D(k,:));
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
    xlabel("total variance")
    xlim([0 1000])
    ylim([0 1])
    
    Vnew=V(:,1:K);
    Dnew=D(1:K,1:K);
    Xnew=Vnew*Dnew*Vnew';
    Xnew=Xnew';
    for l=1:5
        face=reshape(Xnew(l,:),112,92);
        figure()
        imshow(face, []);
        title('Face'+" "+int2str(K))

    end
    
end

end


function [ t_mat ] = total_mat( root_path)
totalsub=40;
impersub=10;
N = totalsub*impersub;
M = 92*112;
t_mat = zeros(M,N);
msg = '';
for s=1:totalsub
    for i=1:10
        nextPath = strcat(root_path, '/s', int2str(s), '/', int2str(i), '.pgm');
        if exist(nextPath, 'file') 
            nextImage = imread(nextPath, 'PGM');
                t_mat(:,(s-1)*impersub+i) = nextImage ( : );
        else
            disp(strcat(msg,'image [', nextPath,'] does not exist.\n'));
        end
    end
end
end