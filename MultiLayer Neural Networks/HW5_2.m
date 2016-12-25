% for different k values : 2 to 10 determine clusters and samples in them , 
%take sets of 2 multiple times  : Determing membership matrix , 
% After taking a set : a= max_diameter(C1,C2);,b=min_distance(C1,C2) ,b/a
%take b/a for all find, minimum ,store it with k , for all k find maximum
clear all;

load('HW5_L.mat');
load('HW5_NL.mat');
X = Main;
X_rows = size(X,1);
X_features= size(X,2);
tcount = 1;
for K =2:10

U = zeros(K,X_rows);%  binary values membership matrix (K*N)
 
ED = zeros(K,X_rows);   % E - euclidian distance matrix for each sample( K*N)-zero
% V = zeros(K,X_features); 
r =1;  % r = 0, mean matrix
 for j = 1:K
     V(j,:) = X(ceil(149*rand()),:);
% %V(j,:) = X(49*j,:);   %perfect
 end
%r =1;


              

    for i = 1:3
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
D_4 = size(U,1);
%objective
    [U,objective]=  Row4D(D,U,i,r,D_4);
     Result(i) = objective;
     U_new = newU(D,U);
     max_diameter = diameter(U,X);
     Unrows = size(U_new,1);
     X_f =1;
     X_final=0;
     for i=1:Unrows
     for j = i+1:Unrows
         distance1 = distance(i,j,U_new,U,D,X);
         x=distance1/max_diameter;
         X_final(1,X_f) = x;
         X_f = X_f + 1;
       V = vmean(U,X);
    end
     end
     minxfinal = min(X_final);
   
    
    end
     tabl(tcount,:)= [K , minxfinal];
    tcount = tcount +1;
end



%5) update V(k*p)  from new U(k*N) (Step-3) ,  calculate objective function (Step-6) determine U(k*N) again ( Step-4)
%6) calculate E^2, now index at which u get 1 in U find E(index)


 