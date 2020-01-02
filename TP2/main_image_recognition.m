function [centers,snrI] = main_image_recognition(img_path,noise,noiseParameters)

img = imread(img_path);
img_puro = img;
if strcmp(noise, 'gaussian')
    img = addNoise(img,noise,noiseParameters(1),noiseParameters(2));
else
    img = addNoise(img,noise,noiseParameters(1));
end


snrI = calculaSNR(double(img(:)),double(img_puro(:)));

%filter = fspecial('average',3);
%img = imfilter(img,filter);

%medfilt2(img,[5,5]);

img = imgaussfilt(img,5,'FilterSize',11,'FilterDomain','spatial');


figure(1);

subplot(2,2,1),imhist(img);
img = histeq(img);
subplot(2,2,2),imhist(img);
can = edge(img,'Canny', [0.05 0.1]);

subplot(2,2,3),imshow(can);
can = edge(img,'Canny');
subplot(2,2,4),imshow(can);



[centers, radii, metric] = imfindcircles(can,[200 300],'Sensitivity',0.97);

figure(2);
subplot(2,2,1), imshow(img);

subplot(2,2,2),imshow(img),viscircles(centers, radii,'EdgeColor','b');
    
subplot(2,2,3),imshow(can);


end

