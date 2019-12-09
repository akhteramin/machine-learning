function [trainlabel,traindata] = readtrain()
% read training data from the given examples in class
% Input:
%    - nclass: 2 or 3, to read for the 2-class or 3-class examples
%    - nexample: 1 or 2, to read for the first or second example in each case
% following the order presented in the lecture note
% output:
%    - trainlabel: vector of discrete numbers represent the cateory of each
%    training data belongs to
%    - traindata: matrix, each column is one training data and the number
%    of columns is the number of data in the set

       [img, label,PC,Ktol] = read_hw("svd");
       rootpath="./att_faces";
       [image]=total_mat(rootpath);
       
       
       [trainImage]=readyTrainImage(image');
       disp(size(trainImage));
       trainImage=trainImage';
       
       
       
       trainImage=PC'*trainImage;
       
       
       
       traindata = trainImage;
       oneMat=ones(1,280);
      
       
       Z=[oneMat; traindata(1:Ktol,1:280)];
       combos = nchoosek(2:6,2)
       for i=1:length(combos)
           Z=[Z;Z(combos(i,1),:).*Z(combos(i,2),:)];
       end
    
       trainlabel = [];
       for i=1:280
           if rem(i,8)~=0
               trainlabel(i)=floor(i/8)+1;
           else
               trainlabel(i)=floor(i/8);
           end
       end
       y=trainlabel;
       
       
       Y=zeros(35,280);
       
        for i=1:280
            Y(y(i),i)=1;
        end
        
       disp(size(Y))
       disp(size(Z))
       
%        W=Y*Z'*inv(Z*Z');

       W=((Z*Z')\(Z*Y'))';
       writematrix(W,"W_tab.txt",'Delimiter','tab');
        type 'W_tab.txt';
       
       %disp(size(b))
       %disp(size(A))
        
       readtest(W,PC,image,Ktol)

end
function [ t_mat ] = total_mat( root_path)
totalsub=40;
impersub=10;
N = totalsub*impersub;
M = 92*112;
t_mat = zeros(M,N);
msg = '';
    for s=1:totalsub
        for i=1:impersub
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
function [trainImage] = readyTrainImage(images)
    [Mp,Np]=size(images);
    
    trainImage=zeros(280,Np);
    j=1;
    for i=1:400
        if rem(i,10)~=9 && rem(i,10)~=0 && i<350
            trainImage(j,:)=images(i,:);
            
            j=j+1;
        end
        
    end
    writematrix(trainImage,"X_tab.txt",'Delimiter','tab');
    type 'X_tab.txt';
    
end