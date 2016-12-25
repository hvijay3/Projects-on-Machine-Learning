function U_new = newU(D,U)
for i =1:size(U,1)
for j = 1:size(U,2)
    if ( U(i,j)==1)
        U_new(i,j) = D(j,i);
    end
end
end
end

    