function [centers] = main_image_recognition(img_path,noise,noiseParameters)

img = imread(img_path);

if strcmp(noise, 'gaussian')
    img = addNoise(img,noise,noiseParameters(1),noiseParameters(2));
else
    img = addNoise(img,noise,noiseParameters(1));
end

%filter = fspecial('average',3);
%img = imfilter(img,filter);

%medfilt2(img,[5,5]);

img = imgaussfilt(img,5,'FilterSize',11,'FilterDomain','spatial');

img = histeq(img);

can = edge(img,'Canny');

[centers, radii, metric] = imfindcircles(can,[200 300],'Sensitivity',0.97);

subplot(2,2,1), imshow(img);

subplot(2,2,2),viscircles(centers, radii,'EdgeColor','b');
    
subplot(2,2,3),imshow(can);

end

