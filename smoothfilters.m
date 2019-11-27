function []=smoothfilters(path)




Imagem = imread(path);
ImagemGS = rgb2gray(Imagem);


main_smoothfilters(ImagemGS,path);




end