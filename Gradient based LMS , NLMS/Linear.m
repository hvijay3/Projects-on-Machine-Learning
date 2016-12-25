load('training.mat');
load('validate.mat');
load('testnoisy.mat');
X = training;
V = validate;
Size_X = size(training,1);
    Size_V = size(validate,1);
order = [4,8,15,22,30];
lambda = [0.001,0.005,0.01,0.05,0.1];
red_x = X;
red_v = V;

count =1;
for order_index =1:5;
    red_x = X;
red_v = V;
    o=order(order_index);
    red_x(1:o,:)=[];
red_v(1:o,:)=[];
Design_X = zeros(Size_X - o,o);
Design_V = zeros(Size_V - o,o);
for k = 1:5
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
zlabel('Mean Square Error');
title('Scatter plot for validation set (Mean Square Error and Hyperparameters)');




    



    
