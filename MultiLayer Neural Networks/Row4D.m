function [U,objective]= Row4D(D,U,i,r,D_4)

 if (i==1) && (r == 0)
for Drow = 1:size(D,1)
%     if range(D(Drow)) == 0
    D(Drow,D_4) = ceil(size(U,1)*rand());
%     end 
end
end
if r ==0 && i > 1
      [M,I] = min(D,[],2);
%         
         D(:,D_4) = I;
end
if r==1 && i>=1
%         
         [M,I] = min(D,[],2);
%         
         D(:,D_4) = I;
 end
% 
 for Drow = 1:size(D,1)
     U(D(Drow,D_4),Drow) = 1;
 end
 objective = 0;
 for Drow = 1:size(D,1)
    objective=  D(Drow,D(Drow,D_4)) + objective;
     
 end
    
end
    
    

