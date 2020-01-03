function [res] = calculaSNR(img,noisyImage)
img=im2double(img);
noisyImage= im2double(noisyImage);
avg = mean(mean(img));

sumP=0;
sumN=0;

[sx,sy] = size(img);

for i = 1:sx
    for j = 1:sy
        sumP = sumP + (img(i,j) - avg).^2;
        sumN = sumN + (img(i,j) - noisyImage(i,j)).^2;
    end
end

res = 10*log10(sumP/sumN);

end

