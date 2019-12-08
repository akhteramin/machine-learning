function [trainlabel,traindata] = readtrain(nclass,nexample)
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

if nclass == 2
    if nexample == 1
        fid = fopen('traindata2C.txt','r');
        traindata = fscanf(fid,'%f %f \n',[2, 200]);
        fclose(fid);
        oneMat=ones(1,200);

        
        Z=[oneMat;traindata];
        fid = fopen('trainlabel2C.txt','r');
        trainlabel = fscanf(fid,'%d \n',[1, 200]);
        fclose(fid);
        y=trainlabel;
        Y=zeros(2,200)
        for i=1:200
            if y(i)==1
                Y(1,i)=1;
            else
                Y(2,i)=1;
            end
        end
        %b=Y*Z';
        %A=Z*Z';

        W=Y*Z'*inv(Z*Z');
        %disp(size(b))
        %disp(size(A))
        disp(size(W));
        disp(W);
        readtest(nclass,nexample,W)
    elseif nexample == 2
        fid = fopen('traindata_ESL_2C.txt','r');
        traindata = fscanf(fid,'%f %f \n',[2, 200]);
        fclose(fid);
        oneMat=ones(1,200);

        
        Z=[oneMat;traindata];
        fid = fopen('trainlabel_ESL_2C.txt','r');
        trainlabel = fscanf(fid,'%d \n',[1, 200]);
        fclose(fid);
        y=trainlabel;
        Y=zeros(2,200)
        for i=1:200
            if y(i)==1
                Y(1,i)=1;
            else
                Y(2,i)=1;
            end
        end
        %b=Y*Z';
        %A=Z*Z';

        W=Y*Z'*inv(Z*Z');
        %disp(size(b))
        %disp(size(A))
        disp(size(W));
        disp(W);
        readtest(nclass,nexample,W)
%     else
%         fid = fopen('traindata2C_uv.txt','r');
%         traindata = fscanf(fid,'%f %f \n',[2, 200]);
%         fclose(fid);
%         fid = fopen('trainlabel2C_uv.txt','r');
%         trainlabel = fscanf(fid,'%d \n',[1, 200]);
%         fclose(fid);
     end
elseif nclass == 3
    if nexample == 2
        fid = fopen('traindata3C.txt','r');
        traindata = fscanf(fid,'%f %f \n',[2, 300]);
        fclose(fid);
        oneMat=ones(1,300);
        
        Z=[oneMat;traindata];
        fid = fopen('trainlabel3C.txt','r');
        trainlabel = fscanf(fid,'%d \n',[1, 300]);
        fclose(fid);
        y=trainlabel;
        Y=zeros(2,300)
        for i=1:300
            if y(i)==1
                Y(1,i)=1;
            else
                Y(2,i)=1;
            end
        end
        %b=Y*Z';
        %A=Z*Z';

        W=Y*Z'*inv(Z*Z');
        %disp(size(b))
        %disp(size(A))
        disp(size(W));
        disp(W);
        readtest(nclass,nexample,W)
    else
        fid = fopen('traindata_ESL_3C.txt','r');
        traindata = fscanf(fid,'%f %f \n',[2, 300]);
        fclose(fid);
        fid = fopen('trainlabel_ESL_3C.txt','r');
        trainlabel = fscanf(fid,'%d \n',[1, 300]);
        fclose(fid);
    end
elseif nclass == 10
       [image, label] = read_hw("eigen");
       traindata = image(:,1:16000);
       oneMat=ones(1,16000);
        
       Z=[oneMat;traindata;];
        
       combos = nchoosek(1:30,3)
       for i=1:length(combos)
           Z=[Z;Z(combos(i,1),:).*Z(combos(i,2),:).*Z(combos(i,3),:)];
       end
        
       trainlabel = label(1:16000)+1;
       y=trainlabel;
       
       Y=zeros(10,16000);
        for i=1:16000
            if (y(i)+1)==1
                Y(1,i)=1;
            elseif (y(i)+1)==2
                Y(2,i)=1;
            elseif (y(i)+1)==3
                Y(3,i)=1;
            elseif (y(i)+1)==4
                Y(4,i)=1;
            elseif (y(i)+1)==5
                Y(5,i)=1;
            elseif (y(i)+1)==6
                Y(6,i)=1;
            elseif (y(i)+1)==7
                Y(7,i)=1;
            elseif (y(i)+1)==8
                Y(8,i)=1;
            elseif (y(i)+1)==9
                Y(9,i)=1;
            elseif (y(i)+1)==10
                Y(10,i)=1;
            end
        end
%         W=Y*Z'*inv(Z*Z');
        
       W=(Y*Z')'\(Z*Z');
        writematrix(W,"W_tab.txt",'Delimiter','tab');
       type 'W_tab.txt';
       
       %disp(size(b))
       %disp(size(A))
        
       readtest(nclass,nexample,W)
       
elseif nclass == 11
       [img, label,PC,Ktol] = read_hw("svd");
       rootpath="./att_faces";
       [image]=total_mat(rootpath);
       for i=1:280
            meanX=mean(image(i,:));
            image(i,:)=(image(i,:)-meanX)./sqrt(400);
       end
       
       disp(size(image));
       traindata = image;
       oneMat=ones(1,280);
       traindata=[oneMat;traindata];
       Z=PC'*traindata;
       Z = Z(1:Ktol, : );
%        combos = nchoosek(1:30,3)
%        for i=1:length(combos)
%            Z=[Z;Z(combos(i,1),:).*Z(combos(i,2),:).*Z(combos(i,3),:)];
%        end
%         
       trainlabel = [];
       for i=1:280
           trainlabel(i)=(i/8)+1
       end
       y=trainlabel;
       
       Y=zeros(8,280);
        for i=1:280
            if y(i)==1
                Y(1,i)=1;
            elseif y(i)==2
                Y(2,i)=1;
            elseif y(i)==3
                Y(3,i)=1;
            elseif y(i)==4
                Y(4,i)=1;
            elseif y(i)==5
                Y(5,i)=1;
            elseif y(i)==6
                Y(6,i)=1;
            elseif y(i)==7
                Y(7,i)=1;
            elseif y(i)==8
                Y(8,i)=1;
%             elseif (y(i)+1)==9
%                 Y(9,i)=1;
%             elseif (y(i)+1)==10
%                 Y(10,i)=1;
            end
        end
%         W=Y*Z'*inv(Z*Z');
        
       W=((Z*Z')\(Z*Y'))';
        writematrix(W,"W_tab.txt",'Delimiter','tab');
       type 'W_tab.txt';
       
       %disp(size(b))
       %disp(size(A))
        
       readtest(nclass,nexample,W)
end
end
function [ t_mat ] = total_mat( root_path)
totalsub=35;
impersub=8;
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