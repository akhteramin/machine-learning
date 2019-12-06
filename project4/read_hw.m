function [] = read_hw(type)
%output: image: nxN matrix, each column is an image
% label: Nx1 vector, label for the digit for each imag
fid = fopen('train-images-idx3-ubyte','r');
fid2 = fopen('train-labels-idx1-ubyte','r');

mn = fread(fid,4,'uint8');

ni = fread(fid,4,'uint8');

nr = fread(fid,4,'uint8');

nc = fread(fid,4,'uint8');

mn2 = fread(fid2,4,'uint8');
ni2 = fread(fid2,4,'uint8');

label = fread(fid2,60000,'uint8');
% 
% ln0 = length(find(label==0));
% ln1 = length(find(label==1));
% ln2 = length(find(label==2));
% ln3 = length(find(label==3));
% ln4 = length(find(label==4));
% fourValue=find(label==4);
% ln5 = length(find(label==5));
% ln6 = length(find(label==6));
% ln7 = length(find(label==7));
% ln8 = length(find(label==8));
% ln9 = length(find(label==9));

image = zeros(2000,28*28);
X=zeros(2000,28*28);
for i=1:2000
    image(i,:) = fread(fid,28*28,'uint8');
    meanX=mean(image(i,:));
    X(i,:)=image(i,:)-meanX;
end
X=X';
%image = image';

U=[];S=[];V=[];
if strcmp(type,"svd")
    [U,S,V] = svd(X);
    g=S*S';
    totalVariance=sum(sum(g));
    sumSigma=zeros(length(S),1);
    sumS=0;
    K=0;
    for k=1:length(g)
        sumSigma(k)=sum(g(k,:));
        sumS=sumS+sumSigma(k);
        sumSigma(k)=sumS/totalVariance;
        if sumS/totalVariance>=0.9
            K=k;
        end
    end
    plot(sumSigma,"o")
    xlabel("total variance"+int2str(totalVariance)+" "+int2str(S(1,1)))
    xlim([0 784])
    ylim([0 1])
    
    Unew=U(:,1:K);
    Vnew=V(:,1:K);
    Snew=S(1:K,1:K);
    Xnew=Unew*Snew*Vnew';
    Xnew=Xnew';
    for l=1:5
        B=reshape(Xnew(l,:),[28,28])
        figure;
        imshow(B, 'InitialMagnification', 'fit')
        title('4')
    end

else
    [V,D]=eig(X*X');
    [D,idx]=sort(sort(D,1,'descend'),2,'descend');
    D=diag(D(1,:));
    totalVariance=sum(sum(D));
    sumSigma=zeros(784,1)
    sumS=0;
    K=0;
    for k=1:784
        sumSigma(k)=sum(D(k,:));
        sumS=sumS+sumSigma(k);
        sumSigma(k)=sumS/totalVariance;
        if sumS/totalVariance>=0.9
            K=k;
        end
    end
    plot(sumSigma,"o")
    xlabel("total variance")
    xlim([0 784])
    ylim([0 1])
    
    Vnew=V(:,1:K);
    Dnew=D(1:K,1:K);
    Xnew=Vnew*Dnew*Vnew';
    Xnew=Xnew';
    for l=1:5
        B=reshape(Xnew(l,:),[28,28])
        figure;
        imshow(B, 'InitialMagnification', 'fit')
        title('4'+int2str(K))
    end
    
end



