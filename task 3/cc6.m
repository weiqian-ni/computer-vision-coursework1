intrinsic_matrix = [2948 0 0; 0 2975.4 0; 2054.8 973.1882 1];

% figure;
% imshow(imread('checker.jpg'));
% axis on;
% hold on;
% plot(850,435, 'r+', 'MarkerSize', 20, 'LineWidth', 2);
% plot(957,328, 'r+', 'MarkerSize', 20, 'LineWidth', 2);
% plot(1065,221, 'r+', 'MarkerSize', 20, 'LineWidth', 2);
% plot(1174,112, 'r+', 'MarkerSize', 20, 'LineWidth', 2);

Rt = [0.9797 0.0369 -0.1969; 0.0037 0.9794 0.2021; 0.2003 -0.1987 0.9594; -224.3549 -132.8641 463.7116];


% 107 pixels represent one block
%center x=5 block, y= 3 block, 
x_true_o =  14 * 29;
y_true_o =  14 * 29;

x_1 = 15 * 9;
y_1 = 13 * 9;

x_2 = 16 * 9;
y_2 = 12 * 9;

x_3 = 17 * 9;
y_3 = 11 * 9;

x_4 = 19 * 9;
y_4 = 9 * 9;

x_5 = 21 * 9;
y_5 = 7 * 9;

x_6 = 23 * 9;
y_6 = 5 * 9;

x_7 = 25 * 9;
y_7 = 3 * 9;

x_8 = 26 * 9;
y_8 = 2 * 9;

x_9 = 27 * 9;
y_9 = 1 * 9;

x_10 = 28 * 9;
y_10 = 0 * 9;



x_loc1 = [x_true_o y_true_o 0 1] * Rt * intrinsic_matrix;
x_loc1 = [x_loc1(1)/x_loc1(3),x_loc1(2)/x_loc1(3)];

x_loc2 = [x_1 y_1 0 1] * Rt * intrinsic_matrix;
x_loc2 = [x_loc2(1)/x_loc2(3),x_loc2(2)/x_loc2(3)];

x_loc3 = [x_2 y_2 0 1] * Rt * intrinsic_matrix;
x_loc3 = [x_loc3(1)/x_loc3(3),x_loc3(2)/x_loc3(3)];

x_loc4 = [x_3 y_3 0 1] * Rt * intrinsic_matrix;
x_loc4 = [x_loc4(1)/x_loc4(3),x_loc4(2)/x_loc4(3)];

x_loc5 = [x_4 y_4 0 1] * Rt * intrinsic_matrix;
x_loc5 = [x_loc5(1)/x_loc5(3),x_loc5(2)/x_loc5(3)];

x_loc6 = [x_5 y_5 0 1] * Rt * intrinsic_matrix;
x_loc6 = [x_loc6(1)/x_loc6(3),x_loc6(2)/x_loc6(3)];

x_loc7 = [x_6 y_6 0 1] * Rt * intrinsic_matrix;
x_loc7 = [x_loc7(1)/x_loc7(3),x_loc7(2)/x_loc7(3)];

x_loc8 = [x_7 y_7 0 1] * Rt * intrinsic_matrix;
x_loc8 = [x_loc8(1)/x_loc8(3),x_loc8(2)/x_loc8(3)];

x_loc9 = [x_8 y_8 0 1] * Rt * intrinsic_matrix;
x_loc9 = [x_loc9(1)/x_loc9(3),x_loc9(2)/x_loc9(3)];

x_loc10 = [x_9 y_9 0 1] * Rt * intrinsic_matrix;
x_loc10 = [x_loc10(1)/x_loc10(3),x_loc10(2)/x_loc10(3)];

x_loc11 = [x_10 y_10 0 1] * Rt * intrinsic_matrix;
x_loc11 = [x_loc11(1)/x_loc11(3),x_loc11(2)/x_loc11(3)];

figure;
imshow(imread('cc6.jpg'));
axis on;
hold on;

plot(x_loc1(1),x_loc1(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
plot(x_loc2(1),x_loc2(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
plot(x_loc3(1),x_loc3(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
plot(x_loc4(1),x_loc4(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);

plot(x_loc5(1),x_loc5(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
plot(x_loc6(1),x_loc6(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);

plot(x_loc7(1),x_loc7(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
plot(x_loc8(1),x_loc8(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);

plot(x_loc9(1),x_loc9(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
plot(x_loc10(1),x_loc10(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);

plot(x_loc11(1),x_loc11(2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);

plot(2054,973, 'r+', 'MarkerSize', 20, 'LineWidth', 2);


coordHoridistx = 26:-1:0;
skilx = coordHoridistx .* 9;

z = zeros(1,27);

xs = [];
ys=[]
for i=1:27
    x_loch = [skilx(i) 0 0 1] * Rt * intrinsic_matrix;
    xs(end+1) = x_loch(1)/x_loch(3);
    ys(end+1) = x_loch(2)/x_loch(3);
end

plot(xs,ys, 'r+', 'MarkerSize', 10, 'LineWidth', 2);


undistorted = undistortImage(imread('cc6.jpg'),cameraParams_cc6);

figure;
imshow(undistorted);
axis on;
hold on;
plot(xs,ys, 'r+', 'MarkerSize', 10, 'LineWidth', 2);
% 
% plot(x_loc1(1),x_loc1(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% plot(x_loc2(1),x_loc2(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% plot(x_loc3(1),x_loc3(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% plot(x_loc4(1),x_loc4(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% 
% plot(x_loc5(1),x_loc5(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% plot(x_loc6(1),x_loc6(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% 
% plot(x_loc7(1),x_loc7(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% plot(x_loc8(1),x_loc8(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% 
% plot(x_loc9(1),x_loc9(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% plot(x_loc10(1),x_loc10(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
% 
% plot(x_loc11(1),x_loc11(2), 'b+', 'MarkerSize', 10, 'LineWidth', 2);
