
clear all;
load('training.mat');
load('testnoisy.mat');
X =training;
v =testnoisy;
Size_X = size(training,1);
    Size_V = size(testnoisy,1);
order = [4,8,30];
lambda = [0.001];
red_x = X;
red_v = V;

count =1;
for order_index =1:3;
    red_x = X;
red_v = V;
    o=order(order_index);
    red_x(1:o,:)=[];
red_v(1:o,:)=[];
Design_X = zeros(Size_X - o,o);
Design_V = zeros(Size_V - o,o);
for k = 1:1
    l = lambda(k);
    lambdaeye = l*eye(o);

 for i = o +1 : Size_X; 
     for j = 1:o
       Design_X(i-o,j)= X(i-j);
    end
end
    for i = o +1 : Size_V
    for j = 1:o
       Design_V(i-o,j)= V(i-j);
    end
    end
   
   R = inv(Design_X'*Design_X + lambdaeye );
   P = (Design_X'*red_x);
    Parameter_M = R*P;
    A_predicted = (Design_V)* Parameter_M;
error = A_predicted-red_v;
error_square = 0;
for e =1:size(error,1)
    error_square = error(e)*error(e) + error_square;
end
mean_error = error_square/size(error,1);

Result(count,:)= [o;l;mean_error];
count = count +1;
end

   
end
scatter3(Result(:,1),Result(:,2),Result(:,3));
xlabel('Regularization parameter');
ylabel('Filter order');
zlabel('Error');
title('Scatter plot for validation set (Error and Hyperparameters)');




    



    
