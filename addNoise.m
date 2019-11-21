function [imgOut] = addNoise(img,noiseType,varargin)
%addNoise Fun��o que adiciona ru�do a uma imagem
%   Devolve uma imagem a partir da original com ru�do gaussiano ou ru�do
%   sal e pimenta
if strcmp('gaussian',noiseType);
    imgOut = imnoise(img,'gaussian',varargin(1),varargin(2));
end

if strcmp('salt & pepper',noiseType);
    imgOut = imnoise(img,'salt & pepper',varargin(1));
end
end

