function [T,nT] = main_image_recognition(img_path,noise,noiseParameters)

img = imread(img_path);
if strcmp(noise, 'gaussian')
    noisyImage = addNoise(img,noise,noiseParameters(1),noiseParameters(2));
else
    noisyImage = addNoise(img,noise,noiseParameters(1));
end

noisyImagepre = noisyImage;
imgpre = img;

snrI = calculaSNR((img),noisyImage);

%filter = fspecial('average',3);
%img = imfilter(img,filter);

%medfilt2(img,[5,5]);

img = imgaussfilt(img,5,'FilterSize',11,'FilterDomain','spatial');
noisyImage = imgaussfilt(noisyImage,5,'FilterSize',11,'FilterDomain','spatial');


%%%%%%% sem ruido %%%%%%

% figure(1);
% title('Imagem sem ru�do');
% subplot(2,2,1),imshow(img);
img = histeq(img);
% subplot(2,2,2),imshow(img);


% subplot(2,2,3),imshow(img)

can = edge(img,'Canny');
% subplot(2,2,4),imshow(can);

%%%%%% ruido %%%%%%

% figure(3);
% title('Imagem com ru�do');
% subplot(2,2,1),imshow(noisyImage);
noisyImage = histeq(noisyImage);
% subplot(2,2,2),imshow(noisyImage);


% subplot(2,2,3),imshow(noisyImage);

noisy_can = edge(noisyImage,'Canny');
% subplot(2,2,4),imshow(noisy_can);


if(strcmp(img_path,'Imagens/coins.jpggray.png'))
    [centers, radii, ~] = imfindcircles(can,[34 100],'Sensitivity',0.92); % 1
    [ncenters, nradii, ~] = imfindcircles(noisy_can,[34 100],'Sensitivity',0.92); % 1
else
    [centers, radii, ~] = imfindcircles(can,[200 300],'Sensitivity',0.97); % 2 e 3
    [ncenters, nradii, ~] = imfindcircles(noisy_can,[200 300],'Sensitivity',0.97); % 2 e 3
end

%
% figure(2);
% title('Imagem sem ru�do');
% 
% subplot(2,2,1), imshow(img);
% 
% subplot(2,2,2),imshow(img),viscircles(centers, radii,'EdgeColor','b');
%     
% subplot(2,2,3),imshow(can);
% subplot(2,2,4),hist(radii);
% 
% figure(4);
% title('Imagem com ru�do');
% subplot(2,2,1), imshow(noisyImage);
% 
% subplot(2,2,2),imshow(noisyImage),viscircles(ncenters, nradii,'EdgeColor','b');
%     
% subplot(2,2,3),imshow(noisy_can);
% subplot(2,2,4),hist(nradii);

figure('Name','Imagem sem ru�do antes do processamento');
imshow(imgpre);

figure('Name','Imagem com ru�do antes do processamento');
imshow(noisyImagepre);

figure('Name','Segmenta��o sem ru�do');
imshow(imgpre),viscircles(centers, radii,'EdgeColor','b');

figure('Name','Segmenta��o com ru�do');
imshow(noisyImagepre),viscircles(ncenters, nradii,'EdgeColor','b');

figure('Name','Histograma do tamanho do raio das moedas da imagem sem ruido');
histogram(radii);
xlabel('Raio')
ylabel('# Moedas');

figure('Name','Histograma do tamanho do raio das moedas da imagem com ruido');
histogram(nradii);
xlabel('Raio')
ylabel('# Moedas');


T = table(centers,radii);
nT = table(ncenters,nradii);

ISR = figure('Name','Identifica��o das moedas sem ru�do');
uit= uitable(ISR,'Data',[centers radii]); uit.ColumnName = {'X','Y','Raio'};

ICR = figure('Name','Identifica��o das moedas com ru�do');
nuit= uitable(ICR,'Data',[ncenters nradii]); nuit.ColumnName = {'X','Y','Raio'};


fprintf('SNR = %.3f dB\n', snrI); 

end

