clear all;
%training and testing set according to percentage
Main = xlsread('HW4.xlsx'); % file with male female and no label
MainF = xlsread('HW4F.xlsx');  % file with gender feature and no label
MainC = xlsread('HW4Main.xlsx');  % Main file with class labels
per = 70/100;
Size_Training= size(Main,1)*per;
    Size_Testing = size(Main,1)-Size_Training;
    for i =1:Size_Training 
    Training(i,:) = MainF(i,:);
    end 
    for i = 1:Size_Testing
    Testing(i,:) = MainF(Size_Training+i,:);
    end 
    
%divide samples in classes in training MAT0 , Mat1
count1=1;
count0=1;
for i = 1: Size_Training
    if MainC(i,1) == 1
        Mat1(count1,:) = Training(i,:);
        count1= count1 +1;
    elseif MainC(i,1) == 0
        Mat0(count0,:) = Training(i,:);
        count0= count0 +1;
    end 
    end
    
%feature reduction if needed

% calculate Mean0, Cov0 , Mean1, Cov1 matrix  , prior probabilties( size of mat0/mat1 upon size training) for each class data
Prior0 = size(Mat0,1)/size(Training,1); %Prior probabilities
Prior1 = size(Mat1,1)/size(Training,1);

Mean0 = mean(Mat0);
Mean1 = mean(Mat1);   % mean of last feature same - redundant

Cov0 = cov(Mat0);
Cov1 = cov(Mat1);
Inv0 = inv(Cov0);
Inv1 = inv(Cov1);
Det0 = det(Cov0);
Det1 = det(Cov1);

%data set on which you want to run
 %Data = Training;
%Data = Testing;
%  Data = MainF;
Data = MainF;
 Result(:,1) = MainC(1:size(Data,1));
% Result(:,1) = MainC((size(Training,1)+1):size(MainC,1),1); % for testing
% calculate g value for each input vector 
% T value ( Threshold value)
t = cputime;
T = 0;
Term2 = 0.5*((Mean0*Inv0*Mean0') - (Mean1*Inv1*Mean1') + T);
K = (0.5*(Cov0 + Cov1))^-1;
for i = 1:size(Data,1)
%Term1 = 0.5*((Mean0*Cov0*Mean0') - (Mean1*Cov1*Mean1') + T);
%K = (0.5*(Cov0 + Cov1))^-1;
Term1 = (K*(Mean1-Mean0)')'*Data(i,:)';
G = Term1 - Term2;

Result(i,2) = G;

%term1 = 0.5*(mean0'*inv(cov0)*mean0 - mean1*inv(cov1)*mean1);
% K = (0.5*(cov0 + cov1))^-1 ,term2 = K*(mean1-mean0)*x 
%term2 - term1 > T decision based on this :
%T = mean(Result(:,2));
if G > 0
Result(i,3) = 1;
else
  Result(i,3) = 0;  

end
if Result(i,1)==Result(i,3);
    Result(i,4) = 1;
else
    Result(i,4) = 0;
end
end
e = cputime-t;
first =0,second =0,third=0,fourth=0;
for i = 1: size(Result,1)
    a = Result(i,1);
    b = Result(i,3);
       if  a== 0 && a==b
first =first +1;
       elseif a==0 && a~=b
           second = second+1;
           elseif a==1 && a~=b
           third = third+1;
           elseif a==1 && a==b
           fourth = fourth + 1;
       end
end
Percentage = (sum(Result(:,4) == 1)/ size(Data,1))*100;
Confusion = [first , second ; third , fourth];