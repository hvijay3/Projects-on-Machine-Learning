

function [U] =  K_Means(Parameters_Gallery)
%load('Parameters_Gallery2.mat');
X = Parameters_Gallery';
X_rows = size(X,1);
X_features= size(X,2);

K = 2;

U = zeros(K,X_rows);%  binary values membership matrix (K*N)
 
ED = zeros(K,X_rows);   % E - euclidian distance matrix for each sample( K*N)-zero
 V = zeros(K,X_features); 
%r =0;  % r = 0, mean matrix
  for j = 1:K
     V(j,:) = X(ceil(100*rand()),:);
 %V(j,:) = X(30*j,:);   %perfect
  end
r =1;


              

    for i = 1:100
        U = zeros(K,X_rows);
        obj=0;

    for Xrow = 1:X_rows
        for cluster = 1:K
            diff(1,:) = X(Xrow,:) - V(cluster,:);
        D(Xrow,cluster) = diff*diff';
        end
     %V = vmean(U,X);
    end
%     if i==1
%         D_4 = size(D,2)+1;
%     end
D_4 = 3;
%objective
    [U,objective]=  Row4D(D,U,i,r,D_4);
     Result(i) = objective;
%     
       V = vmean(U,X);
    end
    plot(Result)
xlabel('Iterations');
ylabel('Objective Function Magnitude');
title('Objective function V/s Iterations');

end

 