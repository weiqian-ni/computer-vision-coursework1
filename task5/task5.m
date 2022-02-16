% I1 = rgb2gray(imread('FD2.jpg'));
% I2 = rgb2gray(imread('FD1.jpg'));
% 
% I1rgb = imread('FD2.jpg');
% I2rgb = imread('FD1.jpg');
image1="2.jpg";
image2="1.jpg";

I1 = rgb2gray(imread(image1));
I2 = rgb2gray(imread(image2));

I1rgb = imread(image1);
I2rgb = imread(image2);



points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);

indexPairs = matchFeatures(f1, f2) ;

matchedPoints1 = vpts1(indexPairs(:, 1)).Location;
matchedPoints2 = vpts2(indexPairs(:, 2)).Location;

[fLMedS,inliers] = estimateFundamentalMatrix(matchedPoints1,...
    matchedPoints2,'NumTrials',4000);

figure;
subplot(121);
imshow(I1rgb);
title("left image");
subplot(122);
imshow(I2rgb);
title("right image");



figure; 
subplot(121);
imshow(I1rgb); 
title('Inliers and Epipolar Lines in First Image'); hold on;
plot(matchedPoints1(inliers,1),matchedPoints1(inliers,2),'go');


epiLines = epipolarLine(fLMedS',matchedPoints2(inliers,:));
points = lineToBorderPoints(epiLines,size(I1));
line(points(:,[1,3])',points(:,[2,4])');

subplot(122); 
imshow(I2rgb);
title('Inliers and Epipolar Lines in Second Image'); hold on;
plot(matchedPoints2(inliers,1),matchedPoints2(inliers,2),'go')

epiLines = epipolarLine(fLMedS,matchedPoints1(inliers,:));
points = lineToBorderPoints(epiLines,size(I2));
line(points(:,[1,3])',points(:,[2,4])');

truesize;

%------------------------------------------------------------------
%rectification
[t1,t2] = estimateUncalibratedRectification(fLMedS, ...
    matchedPoints1,matchedPoints2,size(I2rgb));
tform1 = projective2d(t1);
tform2 = projective2d(t2);

I1React = imwarp(I1rgb,tform1,'OutputView',imref2d(size(I1rgb)));
I2React = imwarp(I2rgb,tform2,'OutputView',imref2d(size(I2rgb)));
pts1Rect = transformPointsForward(tform1,matchedPoints1);
pts2Rect = transformPointsForward(tform2,matchedPoints2);


figure; 
hold on;
subplot(121);
imshow(I1React); 
title('Inliers and Epipolar Lines in First Image'); hold on;
plot(pts1Rect(inliers,1),pts1Rect(inliers,2),'go');

yline(pts1Rect(inliers,2),'-','color','r')



subplot(122); 
imshow(I2React);
title('Inliers and Epipolar Lines in Second Image'); hold on;
plot(pts2Rect(inliers,1),pts2Rect(inliers,2),'go')
yline(pts2Rect(inliers,2),'-','color','r')


truesize;
%--------------------------------------------------------------
%disparity map calculation

imleft = rgb2gray(I1React);
imright = rgb2gray(I2React);
disparityMap = disparitySGM(imleft, imright);
figure;
imshow(disparityMap, [0, 24]);
title('Disparity Map');
colormap jet
colorbar

%------------------------------------------------------------------
%converse the image from the disparity map to the orginal style.

tform1i = tform1;
tform2i = tform2;
tform1i.T= inv(tform1.T);
tform2i.T= inv(tform2.T);

disparityRange=[0 0.25*35*50];

I1Disp = imwarp(disparityMap,tform1i,'OutputView',imref2d(size(disparityMap)));
I2Disp = imwarp(disparityMap,tform2i,'OutputView',imref2d(size(disparityMap)));


IDSP = (1./disparityMap)*35*50;
I1Disp = 1./I1Disp;
I2Disp = 1./I2Disp;


figure; 
hold on;
subplot(121);
imshow(I1Disp, disparityRange); 
title('Depth map of image 1'); 
colormap jet
colorbar

hold on;
subplot(122); 
imshow(I2Disp, disparityRange);
title('Depth map of image 2'); 
colormap jet
colorbar
hold on;

figure;
hold on;
subplot(121);
imshow(disparityMap,[0 24]);
title("Disparity map");
colormap jet
colorbar


hold on;
subplot(122);
imshow(IDSP,disparityRange);
title("Depth map");
colormap jet
colorbar

truesize;

figure;
hold on;
imshow(IDSP, disparityRange);
title("Depth map");
colormap jet
colorbar

truesize;


%------------------------------------------------------------------


