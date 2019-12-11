function [trainlabel,traindata] = trainclassifier()
       %%%%%%%%%%%%%%calling eigen%%%%%%%%%%%%%%%

        eigen('svd',0.9,1);
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       rootpath="./att_faces";
       [image]=total_mat(rootpath);
   
       [trainImage,trainlabel]=readyTrainImage(image');
       disp(size(trainImage));
       [PC,Ktol] = eigen_callee(0.9,0,trainImage);
       trainImage=trainImage';
       
       trainImage=PC'*trainImage;
       traindata = trainImage;
       oneMat=ones(1,280);
      
       
       Z=[oneMat; traindata(1:Ktol,1:280)];
       combos = nchoosek(2:6,2)
       for i=1:length(combos)
           Z=[Z;Z(combos(i,1),:).*Z(combos(i,2),:)];
       end
    
       y=trainlabel;   
       Y=zeros(35,280);
       
        for i=1:280
            Y(y(i),i)=1;
        end
        
       disp(size(Y))
       disp(size(Z))
       

       W=((Z*Z')\(Z*Y'))';
       writematrix(W,"W_tab.txt",'Delimiter','tab');
        type 'W_tab.txt';
       
       %disp(size(b))
       %disp(size(A))
       %%%%Classifier using PCA%%%%%%%%%%%%%%%%%%%%%%%%%

        result0 = identify(W,PC,image,Ktol)
       %%%%Face Identification%%%%%%%%%%%%%%%%%%%%%%%%%
        [result1]=classify_new_images(Ktol, PC,readyTrainImage(image')',readyTestImage(image')')
        
       
       %%%Non Face Identification%%%%%%%%%%%%
        data_objects = load('nonfaces.mat','nonfaces');
        data_objects=data_objects.nonfaces';
% <<<<<<< Updated upstream
%         [result]=classify_new_images(Ktol, PC,readyTrainImage(image')',data_objects)
%         fid = fopen('nonface_final_result.txt','w');
%         fprintf(fid,"percentage of correct ans: %f \n ",(1-(nnz(result))/length(result))*100);
%         fclose(fid);
% z         
%         %%%%%%%%%%%%%%%Classifier using KNN%%%%%%%%%%%%
%         [testImage,testlabel]=readyTestImage(image');
%         [trainImg,trainlabel]=readyTrainImage(image');
% 
%         
%         [accuracy]=KNN(3,trainImg,trainlabel,testImage,testlabel)
%         fid = fopen('KNN_final_result.txt','w');
%         fprintf(fid,"percentage of correct ans: %f \n ",accuracy);
% =======
        %show_data(data_objects');
        [result2]=classify_new_images(Ktol, PC,readyTrainImage(image')',data_objects)
       
        
        %%%%%%%%%%%%%%%Classifier using KNN%%%%%%%%%%%%
        [testImage,testlabel]=readyTestImage_with_known_face(image');
        [trainImg,trainlabel]=readyTrainImage(image');
        
        [accuracy]=KNN(1,trainImg,trainlabel,testImage,testlabel)
        fid = fopen('All_result.txt','w');
        fprintf(fid,"Face Identification percentage of correct ans: %f \n ",(1-(nnz(result0))/length(result0))*100);
        fprintf(fid,"Face Data percentage of correct ans: %f \n ",((nnz(result1))/length(result1))*100);        
        fprintf(fid,"Non-face data percentage of correct ans: %f \n ",(1-(nnz(result2))/length(result2))*100);
        fprintf(fid,"Face identificaiton with KNN percentage of correct ans: %f \n ",accuracy*100);
        fclose(fid);


end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%test and identify%%%%%%%%%%%%%%%%
function [Ans] = identify(W,PC,image,Ktol)
        
       test_image_number = 70;
       %[testImage,label]=readyTestImage(image');
       [testImage,label]=readyTestImage_with_known_face(image');
       disp(size(testImage));
       testImage=testImage';
       testImage=PC'*testImage;
       
       oneMat=ones(1,test_image_number);
      
       
       X=[oneMat; testImage(1:Ktol,1:test_image_number)];
        
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
%         writematrix(newY,"Y_tab.txt",'Delimiter','tab');
%         type 'Y_tab.txt';
        Ans=YReal'-newY;
%         writematrix([YReal' newY],"Ans_tab.txt",'Delimiter','tab');
%         type 'Ans_tab.txt';
%         fid = fopen('final_result.txt','w');
%         fprintf(fid,"percentage of correct ans: %f \n ",(1-(nnz(Ans))/length(Ans))*100);
%         fclose(fid);
        
       
% else
%         fid = fopen('testdata.txt','r');
%         testdata = fscanf(fid,'%f %f \n',[2, 20]);
%         fclose(fid);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Select and Build Test Images & Labels%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Select and Build Test Images & Labels%%%%%%%%%%%%%%%%

function [testImage,label] = readyTestImage_with_known_face(images)
    [Mp,Np]=size(images);
    testImage=zeros(70,Np);
    label=zeros(70,1);
    disp(size(images));
    disp(size(testImage));
    j=1;
    for i=1:350
        if (rem(i,10)==9 || rem(i,10)==0)
            testImage(j,:)=images(i,:);
            if rem(i,10)~=0
                label(j)=floor(i/10)+1;
            else
                label(j)=floor(i/10);
            end
            j=j+1;
        
%         elseif i>350
%             testImage(j,:)=images(i,:);
%             if rem(i,10)~=0
%                 label(j)=floor(i/10)+1;
%             else
%                 label(j)=floor(i/10);
%             end
%             j=j+1;
            
        end
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Convert raw images to dataset%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Select and Build Train Images & Labels%%%%%%%%%%%%%%%%

function [trainImage,trainlabel] = readyTrainImage(images)
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
    
   trainlabel = zeros(280,1);
   for i=1:280
       if rem(i,8)~=0
           trainlabel(i)=floor(i/8)+1;
       else
           trainlabel(i)=floor(i/8);
       end
   end
    
end



%%%%%%%%%%%%%%%%%%identify New images by using K-mean%%%%%%%%%%%%%%%%%%
function [ result ] = classify_new_images(Ktol, PC, data_train, dataTest)
    % dataTest: Images to be classified.
    % result  : Returns 1 or 0
    %[img, label,PC,Ktol] = eigen("svd",0.86,0);
    K = Ktol;
    data_train = PC' * data_train;
    data_train = data_train(1:K, : );
    dataTest = PC' * dataTest;
    dataTest = dataTest(1:K, : );

    % Get centroid of traiing data
    data_train = data_train';
    dataTest = dataTest';
    [idxs,centroid,sum_squred_dist,squred_dists] = kmeans(data_train,1,'distance','sqEuclidean');

    dists = sqrt(squred_dists);

    % Classifying testing data using centroid
    [tn,tp] = size(dataTest);
    result = zeros(tn,1);
    threshold = prctile(dists, 100);
    for i =1:tn
        x = dataTest(i,:);
        dist_to_centroid = norm(centroid - x);
        if dist_to_centroid < threshold
            result(i) = 1;
        else
            result(i) = 0;
        end

    end
%     writematrix(result,"K_Means_Identification_Result.txt",'Delimiter','tab');
%     type 'K_Means_Identification_Result.txt';
    
end

% %%%%%%%%%%%%%%%%%%%%KNN classifier%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [accuracy] = KNN(k,traindata,labels,testdata,testlabels)
    %initialization
   
    
    pred_labels=zeros(size(testdata,1),1);
    euclid_dist=zeros(size(testdata,1),size(traindata,1)); 
    ind=zeros(size(testdata,1),size(traindata,1));
    k_nn=zeros(size(testdata,1),k); 
    
    
    
    for i=1:size(testdata,1)
        for j=1:size(traindata,1)
            euclid_dist(i,j)=sqrt(sum((testdata(i,:)-traindata(j,:)).^2));
        end
        [euclid_dist(i,:),ind(i,:)]=sort(euclid_dist(i,:));
%         ed(test_point,:)=ed(test_point,:);

    end
    
    k_nn=ind(:,1:k);
    k_nn_options=k_nn';
    %get the majority vote 
    for i=1:size(k_nn,1)
        options=unique(labels(k_nn_options(:,i)));
        max_count=0;
        max_label=0;
        for j=1:length(options)
            count=length(find(labels(k_nn_options(:,i))==options(j)));
            if count>max_count
                max_label=options(j);
                max_count=count;
            end
        end
        pred_labels(i)=max_label;
    end
    writematrix(pred_labels,"k_nn.txt",'Delimiter','tab');
    type 'k_nn.txt';
    accuracy=length(find(pred_labels==testlabels))/size(testdata,1);
end