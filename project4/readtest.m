function [testdata] = readtest(nclass,nexample)
% read test data from the given examples in class
% Input:
%    - nclass: 2 or 3, to read for the 2-class or 3-class examples
%    - nexample: 1 or 2, to read for the first or second example in each case
% following the order presented in the lecture note
% output:
%    - testdata: matrix, each column is one test data and the number
%    of columns is the number of data in the set

if nclass ==2
    if nexample == 1
        fid = fopen('testdata2C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 20]);
        fclose(fid);
    elseif nexample == 2
        fid = fopen('testdata_ESL_2C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 20]);
        fclose(fid);
%     else
%         fid = fopen('testdata2C_uv.txt','r');
%         testdata = fscanf(fid,'%f %f \n',[2, 20]);
%         fclose(fid);
    end
elseif nclass == 3
    if nexample == 2
        fid = fopen('testdata3C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 30]);
        fclose(fid);
    else
        fid = fopen('testdata_ESL_3C.txt','r');
        testdata = fscanf(fid,'%f %f \n',[2, 30]);
        fclose(fid);
    end
elseif nclass == 10
       [img, ~] = read_hw;
       testdata = img(:,16001:20000);
% else
%         fid = fopen('testdata.txt','r');
%         testdata = fscanf(fid,'%f %f \n',[2, 20]);
%         fclose(fid);
end
end
    
