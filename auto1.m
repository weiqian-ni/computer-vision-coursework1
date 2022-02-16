

I1 = rgb2gray(imread("rabbitHG1.jpg"));
I2 = rgb2gray(imread("rabbitHG2.jpg"));

I1rgb = imread("rabbitHG1.jpg");
I2rgb = imread("rabbitHG2.jpg");

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);

indexPairs = matchFeatures(f1, f2) ;
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));

figure; ax = axes;
showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage','Parent',ax);
title(ax, 'Candidate point matches');
legend(ax, 'Matched points 1','Matched points 2');


%----------------------------------------------------------------
total_error = 0;
total_errora = 0;
error_list = [];
error_lista = [];
for i = 1:length(matchedPoints2)
    a=matchedPoints1(i);
    b=matchedPoints2(i);
    mat1r = I1rgb(round(a.Location(2))-20:round(a.Location(2))+20,round(a.Location(1))-20:round(a.Location(1))+20,:);
    mat2r = I2rgb(round(b.Location(2))-20:round(b.Location(2))+20,round(b.Location(1))-20:round(b.Location(1))+20,:);
    yRed1 = mat1r(:,:,1);
    yGreen1 = mat1r(:,:,2);
    yBlue1 = mat1r(:,:,3);

    yRed2 = mat2r(:,:,1);
    yGreen2 = mat2r(:,:,2);
    yBlue2 = mat2r(:,:,3);


     yRed1_error = sum(sum(yRed1));
     yRed2_error = sum(sum(yRed2));
     error_1 = (yRed1_error-yRed2_error)^2;
%     
     yGreen1_error = sum(sum(yGreen1));
     yGreen2_error = sum(sum(yGreen2));
     error_2 =  (yGreen1_error - yGreen2_error)^2;
% 
     yBlue1_error = sum(sum(yBlue1));
     yBlue2_error = sum(sum(yBlue2));
     error_3 = (yBlue1_error - yBlue2_error)^2;

     error_list = [error_list  sqrt(error_1 + error_2 + error_3)];
     total_error = total_error + sqrt(error_1 + error_2 + error_3);


end           
mean_error = total_error/(7*1681)
error_evaulation_1 = error_list ./1681


