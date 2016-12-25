function temp = diameter(U,X)
K = size(U,1);
totalmax= 0;
max= 0;
d=0;
for j=1:K
    for i = 1:size(U,2)
        for k = i+1:size(U,2)
            if U(j,i)==1 && U(j,k)==1
                d = (X(i,:)-X(k,:))*(X(i,:)-X(k,:))';
                if max<d
                    max=d;
                end
            end
        end
    end
    if totalmax<max
        totalmax = max;
    end
    temp = totalmax;
end
end

    
            