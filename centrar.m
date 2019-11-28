function [out] = centrar(in)


tamanho=size(in);
out = zeros(tamanho(1),tamanho(2));
for i = 1 : tamanho(1)
    for j = 1 : tamanho(2)
        out(i,j) =  double(in(i,j))*power(-1,i+j);
    end
end

end

