load('training.mat');
load('validate.mat');
load('testnoisy.mat');
X = training;
V = validate;
Size_X = size(training,1);
    Size_V = size(validate,1);
order = [4,8,15,22,30];
cost = 0;
count =1;
% for order_index =1:5;
    
    red_x = X;
red_v = V;
%   o=order(order_index);
o =3;

     %Para = (rand(1,o))'; % Initialize parameters
     Para = zeros(1,o)';
    red_x(1:o,:)=[];
red_v(1:o,:)=[];
Design_X = zeros(Size_X - o,o);
Design_V = zeros(Size_V - o,o);

 for i = o +1 : Size_X; 
     for j = 1:o
       Design_X(i-o,j)= X(i-j);
    end
 end    %Constructed Design Matrix
    for i = o +1 : Size_V
    for j = 1:o
       Design_V(i-o,j)= V(i-j);
    end
    end    %Find 1st Eigen value of design X and then 1/eigen
   
   R = Design_X'*Design_X;   % Eigen value and limit found
   lambda = eig(R);
   lambda_limit = 1/(lambda(o)+lambda(1));
%     step_size =1/(lambda(o) + lambda(1));
    step_size = 1.29981348466126e-06 ;

    


%    lambda_initial = 0.1*lambda_limit;
%    for step_size = lambda_initial : lambda_initial: lambda_limit

       for iteration = 1: size(red_x,1)
           
           Para(:,1) = Para(:,1) - step_size * ( Design_X(iteration,:)*Para(:,1) - red_x(iteration))*(Design_X(iteration,:))'
          % cost =  cost + ((Design_X(iteration,:)*Para(:,1) - red_x(iteration))*(Design_X(iteration,:)*Para(:,1) - red_x(iteration)));
          %cost = sum((((red_x(1:iteration,:) -(Design_X(1:iteration,:)*Para)).^2)))/iteration;
          cost = sum((((red_x -(Design_X*Para)).^2)))/size(red_x,1);
          
          cost_matrix(iteration,:) = [iteration,cost];
           
       end
      
       
   
% L(max) - Max eigen value lambda = eig(R), Lambda_limit =
% (1/lambda(o)),lambda_initial = 0.1*lambda_limit
% for loop Step_size from lambda_initial to lamda_limit , increament by lambda_initial
% e(n) = red_x - 
%W(n+1)=W(n)+Step_size×e(n)×Design_x( (3)
% Where: d(n)-expected output value of signal; X(n)-input signal vector of time n; W(n)-weight
% vector of adaptive filter at time n; e(n)-error signal; ?(n)-regulated step size. 


figure;
 plot(cost_matrix(:,1),cost_matrix(:,2));
 xlabel('Iterations');
ylabel('Mean Square Error');
title('Learning curve for MSE vs Iterations for LMS Algorithm');



%     A_predicted = (Design_V)* Para(:,1);
% error = A_predicted-red_v;
% error_square = 0;
% for e =1:size(error,1)
%     error_square = error(e)*error(e) + error_square;
% end
% mean_error = error_square/size(error,1);
% 
% Result(count,:)= [o;step_size;mean_error]; % instead of l using step size
% count = count +1;
% end
%  end

   

%scatter3(Result(:,1),Result(:,2),Result(:,3));
% xlabel('Regularization parameter');
% ylabel('Filter order');
% zlabel('Mean Square Error');
% title('Scatter plot for validation set (Mean Square Error and Hyperparameters)');




    



    
