
function [ train, test ] = exercise( root_path, SN, TN )
% SN = 35;
% TN=8;
    N = SN*TN;
    M = 92*112;
    testN = (10-TN)*SN+(40-SN)*10;
    train = zeros(M,N);
    test = zeros(M, testN);
    msg = '';
    for s=1:SN
        for i=1:10
            nextPath = strcat(root_path, '/s', int2str(s), '/', int2str(i), '.pgm');
            if exist(nextPath, 'file') 
                nextImage = imread(nextPath, 'PGM');
                if (i <= TN)
                    train(:,(s-1)*TN+i) = nextImage ( : );
                else
                    test(:,(s-1)*(10-TN)+i-TN) = nextImage ( : );
                end
            else
                disp(strcat(msg,'image [', nextPath,'] does not exist.\n'));
            end
        end
    end
end
