function [testdata] = readtest(nclass,nexample,W,PC,image,Ktol)
% read test data from the given examples in class
% Input:
%    - nclass: 2 or 3, to read for the 2-class or 3-class examples
%    - nexample: 1 or 2, to read for the first or second example in each case
% following the order presented in the lecture note
% output:
%    - testdata: matrix, each column is one test data and the number
%    of columns is the number of data in the set


if nclass == 11

       [testImage,label]=readyTestImage(image');
       disp(size(testImage));
       testImage=testImage';
       testImage=PC'*testImage;
       
       testImage = testImage;
       oneMat=ones(1,120);
      
       
       X=[oneMat; testImage(1:Ktol,1:120)];
        
       combos = nchoosek(2:6,2)
       for i=1:length(combos)
           X=[X;X(combos(i,1),:).*X(combos(i,2),:)];
       end
        
       testlabel = label;
       YReal=testlabel;
       YReal=YReal';
        
        size(W)
        size(X)
        
        Y=W*X;
        
        Y=Y';
        
        
        
        newY=zeros(length(Y),1);
        for i=1:length(Y)
            [val,idx]=max(Y(i,:));
            disp(idx)
            newY(i)=idx;
        end
        writematrix(newY,"Y_tab.txt",'Delimiter','tab');
        type 'Y_tab.txt';
        Ans=YReal'-newY;
        disp(YReal)
        writematrix(YReal,"Ans_tab.txt",'Delimiter','tab');
        type 'Ans_tab.txt';
        fid = fopen('new.txt','w');
        fprintf(fid,"percentage of correct ans: %f %\n ",(1-(nnz(Ans))/length(Ans))*100);
        fclose(fid);
        
       
% else
%         fid = fopen('testdata.txt','r');
%         testdata = fscanf(fid,'%f %f \n',[2, 20]);
%         fclose(fid);
end
end

function [testImage,label] = readyTestImage(images)
    [Mp,Np]=size(images);
    testImage=zeros(120,Np);
    label=zeros(120,1);
    disp(size(images));
    disp(size(testImage));
    j=1;
    for i=1:400
        if i<=350 && (rem(i,10)==9 || rem(i,10)==0)
            testImage(j,:)=images(i,:);
            if rem(i,10)~=0
                label(j)=floor(i/10)+1;
            else
                label(j)=floor(i/10);
            end
            j=j+1;
        
        elseif i>350
            testImage(j,:)=images(i,:);
            if rem(i,10)~=0
                label(j)=floor(i/10)+1;
            else
                label(j)=floor(i/10);
            end
            j=j+1;
            
        end
        
    end
end

