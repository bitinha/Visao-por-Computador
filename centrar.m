function [out] = centrar(in)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

tamanho=size(in);
out = zeros(tamanho(1),tamanho(2));
for i = 1 : tamanho(1)
    for j = 1 : tamanho(2)
        out(i,j) =  double(in(i,j))*power(-1,i+j);
    end
end

end

