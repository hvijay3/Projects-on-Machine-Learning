clear all;

for i =1:100
    i1 = int2str(i);
    x = strcat('C:\Users\Harshit Vijayvargia\Documents\MATLAB\GallerySet\','subject',i1,'_img1.pgm')
    Gallery_Input = imread(x,'pgm');
    Gallery_Input = im2double(Gallery_Input);
    Gal_Vectors(:,i) = Gallery_Input(:);
end
    Gal_Vectors= Gal_Vectors';
    Mean_Gallery_Input = mean(Gal_Vectors);
    for i=1:100
    G_Mean_Substracted(i,:) = minus(Gal_Vectors(i,:),Mean_Gallery_Input(1,:));
    end
   Covariance =  cov(G_Mean_Substracted);
    [V,D] = eig(Covariance);
    sum_diagonal = trace(D);
    n =0;
    size_d = size(D,1);
    sum_end = trace(D(((size_d - n):size_d),((size_d - n):size_d)));
   
    % Testing
for i =1:100
    i1 = int2str(i);
    x = strcat('C:\Users\Harshit Vijayvargia\Documents\MATLAB\ProbeSet\','subject',i1,'_img2.pgm');
    P_Input2 = imread(x,'pgm');
    P_Input2 = im2double(P_Input2);
    P_Vectors(:,i) = P_Input2(:);
end
for i =1:100
    i1 = int2str(i);
    x = strcat('C:\Users\Harshit Vijayvargia\Documents\MATLAB\ProbeSet\','subject',i1,'_img3.pgm');
    P_Input3 = imread(x,'pgm');
    P_Input3= im2double(P_Input3);
    P_Vectors(:,100+i) = P_Input3(:);
end
  
P_Vectors= P_Vectors';
    Mean_P_Input = mean(P_Vectors);
    for i=1:200
    P_Mean_Substracted(i,:) = minus(P_Vectors(i,:),Mean_P_Input(1,:));
    end
    iter =1;   % for storing values
    
    % K values
    X=1;
    for K = 1:10:50
        if K==10
            X=10;
        end
        n = K-1;
        sum_end = trace(D(((size_d - n):size_d),((size_d - n):size_d)));
        perc = (sum_end/sum_diagonal)*100;

       Eigen_Mat = V_Eigen(K,V);
       Parameters_Gallery = zeros(K,100);
       Parameters_Probe = zeros(K,100);
   for i=1:100
   Parameters_Gallery(:,i)= Eigen_Mat* G_Mean_Substracted(i,:)';
   end
   for i=1:200
   Parameters_Probe(:,i)= Eigen_Mat*P_Mean_Substracted(i,:)';
   end
   % doing testing on gallery
   for i =1:200
   out(:,i) = pdist2(Parameters_Gallery',Parameters_Probe(:,i)'); %
   end
   
   %doing recognition without PCA
%    for i =1:200
%    out(:,i) = pdist2(Gal_Vectors,P_Vectors(i,:)); %
%    end
   % doing testing on training
%     for i =1:100
%    out(:,i) = pdist2(Parameters_Gallery',Parameters_Gallery(:,i)'); %
%    end
   [M I] = min(out);
   count = 0;
   for i =1:size(I,2)
       if i<=100
       if I(:,i)==i
           count = count+1;
       end
       end
       if i>100
           if I(:,i)==i-100
           count = count+1;
           end
       end
   end
   
   %U = K_Means(Parameters_Gallery);   %using mine kmeans
   %using inbuilt
   %C = [Gal_Vectors;P_Vectors]; % recognition without PCA
   C = [Parameters_Gallery';Parameters_Probe'];  % appending % recognition using PCA
   %rng(4);
   
   idx = kmeans(C,2);
   %idx = kmeans(C,2, 'replicates',10);
   [a,b]=hist(idx,unique(idx));
   load('GenderC.mat');
   if ( a(1,1)>a(1,2))
       male =1;
   else 
       male=2;
   end
   if male==2
for i=1:300
    if GenderC(i)==1
GenderC(i)=2;
    else 
        GenderC(i)=1;
    end
end
   end
   Conf = confusionmat(GenderC,idx);
   SConf = zeros(2,2);
   SConf = Conf;
   if ( Conf(2,2)>Conf(1,1))     % Swapping diagonal elements
       Conf(1,2) = SConf(2,1);
       Conf(1,1) = SConf(2,2);
       Conf(2,2) = SConf(1,1);
       Conf(2,1) = SConf(1,2);
   end; 
        beta =1;
   tpos = Conf(1,1);
   tneg = Conf(2,2);
   fpos = Conf(2,1);
   fneg = Conf(1,2);
   prec = tpos/(tpos+fpos);
   reca= tpos/(tpos+fneg);
   fscore = ((1+beta*beta)*prec*reca)/(beta*beta*prec + reca);
   
   Aiter(iter,:) =a;
   
  % su = sum(U,2);   using mine
   %count_mat(iter,:) = [K,count,su(1),su(2),perc];   % using my kmeans
   eva = evalclusters(C,'kmeans','Silhouette','KList',[1:6]);
   %eva = evalclusters(C,'kmeans','CalinskiHarabasz','KList',[1:6]);
   
   
   count_mat(iter,:) = [K,(count/200)*100,Aiter(iter,1),Aiter(iter,2),perc,eva.OptimalK,eva.CriterionValues(1,2),fscore];    % using inbuilt kmeans
   iter = iter +1;
    end
%    
%    end
%    
%     end
   
   
    
   
   
   