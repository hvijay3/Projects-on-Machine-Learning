clear all;
load('Given files/training.mat');
load('Given files/validate.mat');
load('Given files/test.mat');
X = training;
V = validate;
T = test;
Size_X = size(training,1);
    Size_V = size(validate,1);
    Size_T = size(test,1);
order = [8];
lambda = [0.001,0];
red_x = X;
red_v = V;
red_t = T;

count =1;
error_count =1;
for order_index =1:1;
    red_x = X;
red_v = V;
red_t = T;
    o=order(order_index);
    red_x(1:o,:)=[];
red_v(1:o,:)=[];
red_t(1:o,:)=[];
Design_X = zeros(Size_X - o,o);
Design_V = zeros(Size_V - o,o);
Design_T = zeros(Size_V - o,o);
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
    for i = o +1 : Size_T
    for j = 1:o
       Design_T(i-o,j)= T(i-j);
    end
    end
   
   R = inv(Design_X'*Design_X + lambdaeye );
   P = (Design_X'*red_x);
    Parameter_M = R*P;
    A_predicted = (Design_T)* Parameter_M;
error = red_t - A_predicted;
error_square = 0;
for e =1:size(error,1)
    error_square = error(e)*error(e) + error_square;
end

Result(count,:)= [o;l;error_square];
count = count +1;
end

   
end
% plot(error);
% xlabel('Time');
% ylabel('Error');
% title(['Plot for filter order  ',num2str(o)]); 
plot(Design_T);
xlabel('Time');
ylabel('Input');
title(['Input Plot for filter order  ',num2str(o)]);







    



    
