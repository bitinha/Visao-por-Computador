

Imagem = imread('Imagens/lena.jpg');
Imagem = rgb2gray(Imagem);
filterSize = 5;
variance = 0.05;

noisyImage=addNoise(Imagem,'gaussian',0,0.001);


[Es,Em,Final] = main_CannyDetector(noisyImage,filterSize,0.1,0.3*255,0.6*255);

imwrite(Es,strcat('Imagens/lena_edge_canny_',num2str(filterSize),'_',num2str(variance),'.png'));
imwrite(Em,strcat('Imagens/lena_edge_canny_nonmax_',num2str(filterSize),'_',num2str(variance),'.png'));
imwrite(Final,strcat('Imagens/lena_edge_canny_hysteresis_',num2str(filterSize),'_',num2str(variance),'.png'));

