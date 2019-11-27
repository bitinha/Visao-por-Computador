function []=smoothfilters(path)




Imagem = imread(path);
[~, ~, numberOfColorChannels] = size(Imagem);
if(numberOfColorChannels==3)
    Imagem = rgb2gray(Imagem);
end


main_smoothfilters(Imagem,path);




end