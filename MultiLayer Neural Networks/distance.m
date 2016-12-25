function d = distance(i,j,U_new,U,D,X)
min = 10000;
for l=1:size(U_new,2)
    if U(i,l)==1
        for k=1:size(U_new,2)
            if U(j,k)==1
                d = (X(l,:)-X(k,:))*(X(l,:)-X(k,:))'
                if min>d
                    min =d;
                end
            end
        end
    end
end
end
                
                
