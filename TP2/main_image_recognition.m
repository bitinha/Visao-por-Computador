function [centers] = main_image_recognition(img_path,noise,noiseParameters)

img = imread(img_path);

%filter = fspecial('average',20);
%img = imfilter(img,filter);

%medfilt2(img,[5,5]);

img = imgaussfilt(img,5,'FilterSize',11,'FilterDomain','spatial');

%%img = histeq(img);
%if strcmp(noise, 'gaussian')
%    noisyImage = addNoise(img,noise,noiseParameters(1),noiseParameters(2));
%else
%    noisyImage = addNoise(img,noise,noiseParameters(1));
%end

can = edge(img,'Canny');

[centers, radii, metric] = imfindcircles(can,[200 300],'Sensitivity',0.97);
figure(1);
imshow(img);
viscircles(centers, radii,'EdgeColor','b');
    
figure(2);
imshow(can);
end

