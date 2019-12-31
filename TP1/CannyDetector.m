

Imagem = imread('Imagens/castle.png');
Imagem = rgb2gray(Imagem);
filterSize = 5;
variance = 2;

noisyImage=addNoise(Imagem,'gaussian',0,0.01);


[Es,Em,Final] = main_CannyDetector(noisyImage,filterSize,variance,0.3*255,0.6*255);

imwrite(Es,strcat('Imagens/lena_edge_canny_',num2str(filterSize),'_',num2str(variance),'.png'));
imwrite(Em,strcat('Imagens/lena_edge_canny_nonmax_',num2str(filterSize),'_',num2str(variance),'.png'));
imwrite(Final,strcat('Imagens/lena_edge_canny_hysteresis_',num2str(filterSize),'_',num2str(variance),'.png'));

