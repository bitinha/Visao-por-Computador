function [imgOut] = addNoise(img,noiseType,varargin)
%addNoise Função que adiciona ruído a uma imagem
%   Devolve uma imagem a partir da original com ruído gaussiano ou ruído
%   sal e pimenta
if strcmp('gaussian',noiseType);
    imgOut = imnoise(img,'gaussian',varargin(1),varargin(2));
end

if strcmp('salt & pepper',noiseType);
    imgOut = imnoise(img,'salt & pepper',varargin(1));
end
end

