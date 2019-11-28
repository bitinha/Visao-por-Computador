function [noisyImage,smoothedImage] = main_smoothfilters(img,noise,noiseParameters,filter_domain,filterType,filterParameters)

    if strcmp(noise, 'gaussian')
        noisyImage = addNoise(img,noise,noiseParameters(1),noiseParameters(2));
    else
        noisyImage = addNoise(img,noise,noiseParameters(1));
    end
    
    
    
    
    if strcmp(filter_domain,'spatial')
        if strcmp(filterType,'average')
            filter = fspecial('average',filterParameters);
            smoothedImage = imfilter(noisyImage,filter);
        elseif strcmp(filterType,'gaussian')
            smoothedImage = imgaussfilt(noisyImage,filterParameters(2),'FilterSize',filterParameters(1),'FilterDomain','spatial');
        else
            smoothedImage = medfilt2(noisyImage,[filterParameters(1),filterParameters(1)]);%Ainda da para especificar o padding
        end
    else
        
        [xs,ys] = size(img);
        noisyImage = im2double(noisyImage);

        padded = padarray(noisyImage,[xs ys],'post');
        
        padded = centrar(padded);
        
        FN=fft2((padded));
        
        if strcmp(filterType,'butterworth') % ButterWorth
            cf = filterParameters(1);
            fo = filterParameters(2);
            H = zeros(xs,ys);
            for i = 1 : xs*2
                for j = 1:ys*2
                    dist =sqrt((i-xs).^2 + (j-ys).^2);
                    H(i,j) = 1/(1+(dist/cf).^fo);
                end
            end
            G= FN .* H;
            G=ifft2(G);
            smoothedImage = centrar(G);
            smoothedImage = smoothedImage(1:xs,1:ys);
        else %Gaussiano
            cf = filterParameters(1);
            H = zeros(xs,ys);
            for i = 1 : xs*2
                for j = 1:ys*2
                    dist =sqrt((i-xs).^2 + (j-ys).^2);
                    H(i,j) = exp(-(dist.^2)/(2*cf.^2));
                end
            end
            G= FN .* H;
            G=ifft2(G);
            smoothedImage = centrar(G);
            smoothedImage = smoothedImage(1:xs,1:ys);
            
        end
    end
    
%{
tamanho = size(img);

img = im2double(img);
noisyImage = im2double(noisyImage);
smoothedImage = im2double(smoothedImage);

img = padarray(img,tamanho,'post');
noisyImage = padarray(noisyImage,tamanho,'post');
smoothedImage = padarray(smoothedImage,tamanho,'post');

img = centrar(img);
noisyImage = centrar(noisyImage);
smoothedImage = centrar(smoothedImage);

FI=fft2((img));
figure;
imshow(uint8(255*mat2gray(log(abs(FI)))));
FN=fft2((noisyImage));
figure;
imshow(uint8(255*mat2gray(log(abs((FN))))));
FS=fft2((smoothedImage));
figure;
imshow(uint8(255*mat2gray(log(abs((FS))))));
%}

end