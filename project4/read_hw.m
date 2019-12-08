function [image,label] = read_hw(typ)
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
rootpath="./att_faces";
[image]=total_mat(rootpath);
image=image';
X=zeros(length(image),92*112);
disp(size(image));
for i=1:400
    meanX=mean(image(i,:));
    X(i,:)=image(i,:)-meanX;
end
X=X';
writematrix(image(1,:)'+" "+image(2,:)',"X_tab.txt",'Delimiter','tab');
type 'X_tab.txt';
image = image';
fclose(fid);


U=[];S=[];V=[];
if strcmp(typ,"svd")
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
        B=reshape(Xnew(l,:),[92,112])
        figure;
        imshow(B, 'InitialMagnification', 'fit')
        title('4')
    end

else
    [V,D]=eig(X*X');
    [D,idx]=sort(sort(D,1,'descend'),2,'descend');
    D=diag(D(1,:));
    totalVariance=sum(sum(D));
    sumSigma=zeros(10304,1)
    sumS=0;
    K=0;
    for k=1:10304
        sumSigma(k)=sum(D(k,:));
        sumS=sumS+sumSigma(k);
        sumSigma(k)=sumS/totalVariance;
        if sumS/totalVariance>=0.9
            K=k;
        end
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
        B=reshape(Xnew(l,:),[92,112])
        figure;
        imshow(B, 'InitialMagnification', 'fit')
        title('4'+int2str(K))
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