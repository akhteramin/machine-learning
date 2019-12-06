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
        
        Z=traindata';
        fid = fopen('trainlabel2C.txt','r');
        trainlabel = fscanf(fid,'%d \n',[1, 200]);
        fclose(fid);
        Y=trainlabel;
        W=(Z'*inv(Z*Z'))*Y';
        fprintf("size W:: %f",length(W))
    elseif nexample == 2
        fid = fopen('traindata_ESL_2C.txt','r');
        traindata = fscanf(fid,'%f %f \n',[2, 200]);
        fclose(fid);
        fid = fopen('trainlabel_ESL_2C.txt','r');
        trainlabel = fscanf(fid,'%d \n',[1, 200]);
        fclose(fid);
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
        fid = fopen('trainlabel3C.txt','r');
        trainlabel = fscanf(fid,'%d \n',[1, 300]);
        fclose(fid);
    else
        fid = fopen('traindata_ESL_3C.txt','r');
        traindata = fscanf(fid,'%f %f \n',[2, 300]);
        fclose(fid);
        fid = fopen('trainlabel_ESL_3C.txt','r');
        trainlabel = fscanf(fid,'%d \n',[1, 300]);
        fclose(fid);
    end
elseif nclass == 10
       [img, lbl] = read_hw;
       traindata = img(:,1:16000);
       trainlabel = lbl(1:16000)+1;
% else
%         fid = fopen('traindata.txt','r');
%         for i=1:3
%             fgetl(fid);
%         end
%         traindata(:,1:100) = fscanf(fid,'%f %f \n',[2, 100]);
%         fgetl(fid);
%         fgetl(fid);
%         traindata(:,101:250) = fscanf(fid,'%f %f \n',[2, 150]);
%         fgetl(fid);
%         fgetl(fid);
%         traindata(:,251:350) = fscanf(fid,'%f %f \n',[2, 100]);
%         fclose(fid);
%         trainlabel = horzcat(ones(1,100),2*ones(1,150),3*ones(1,100));
end