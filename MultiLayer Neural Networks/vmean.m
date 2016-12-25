function V = vmean(U,X)
X_features =size(X,2);
K = size(U,1);
sum = zeros(1,X_features);                            
count1 = 0;
V = zeros(K,X_features);
    for Urow = 1:size(U,1)  
    for Ucol = 1:size(U,2)
        if U(Urow,Ucol)==1
           sum = X(Ucol,:) +sum;
            count1 = count1 + 1;
        end
    end
    V(Urow,:) = (1/count1)*sum;
    sum = zeros(1,X_features);
    count1 = 0;
    end
    
    
    % 3)V ( 3*P) - k means for different clusters - k*P  -  for each cluster there are
% some samples , find 1 in rows of u , for each row( we have to sum each sample (row vector) from input X (n*p) / number of
% ones(samples)
% sum = zeros(1,4);                            % determining V
% count1 = 0;
end