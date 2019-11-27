function [] = main_smoothfilters(img,path)



prompt = 'Which type of noise do you want?\n1-Gaussian\n2-Salt and Pepper\n';
noise = input(prompt,'s');

while(noise ~= '1' && noise ~= '2')
    noise = input(prompt,'s');
end

switch noise
    case '1'
        noise = 'gaussian';
        disp(noise + " noise chosen" );
        prompt = 'Enter a mean for the noise\n';
        mean = input(prompt);
        while(~isnumeric(mean) || ~isscalar(mean) || isnan(mean) || ~isreal(mean))
            disp("Not a valid input");
            mean = input(prompt);
        end
        prompt = 'Enter a variance for the noise\n';
        variance = input(prompt);
        while(~isnumeric(variance) || ~isscalar(variance)  || isnan(variance) || ~isreal(variance))
            disp("Not a valid input");
            variance = input(prompt);
        end
        noisyImage=addNoise(img,noise,mean,variance);
        imwrite(noisyImage,strcat(path,'_',noise,'_',num2str(mean),'_',num2str(variance),'.png'));
    case '2'
        noise = 'salt & pepper';
        disp(noise + " noise chosen" );
        prompt = 'Enter the noise density\n';
        density = input(prompt);
        while(~isnumeric(density) || ~isscalar(density)  || isnan(density) || ~isreal(density))
            disp("Not a valid input");
            density = input(prompt);
        end
        noisyImage = addNoise(img,noise,density);
        imwrite(noisyImage,strcat(path,'_',noise,'_',num2str(density),'.png'));
end
   



prompt = 'Choose filtering domain\n1-Spatial\n2-Frequency\n';
domain = input(prompt,'s');

while(domain ~= '1' && domain ~= '2')
    domain = input(prompt,'s');
end

switch domain
    case '1'
        domain = 'spatial';
        disp(domain + " domain chosen" );
        prompt = 'Choose type of smoothing\n1-Average\n2-Gaussian\n3-Median\n';
        smoothing = input(prompt,'s');
        loop = 1;
        while loop
            loop = 0;
            switch smoothing
                case '1'
                    prompt = 'Enter the size of the filter to apply\n';
                    tamanho = input(prompt);
                    while(~isnumeric(tamanho) || ~isscalar(tamanho)  || isnan(tamanho) || ~isreal(tamanho))
                        disp("Not a valid input");
                        tamanho = input(prompt);
                    end
                    
                    filter = fspecial('average',tamanho);
                    smoothedImage = imfilter(noisyImage,filter);
                    
                    imwrite(smoothedImage,strcat(path,'_smooth_average_',num2str(tamanho),'.png'));
                    
                case '2'
                    prompt = 'Enter the size of the filter to apply\n';
                    tamanho = input(prompt);
                    while(~isnumeric(tamanho) || ~isscalar(tamanho)  || isnan(tamanho) || ~isreal(tamanho))
                        disp("Not a valid input");
                        tamanho = input(prompt);
                    end
                    prompt = 'Enter the deviation of the filter to apply\n';
                    deviation = input(prompt);
                    while(~isnumeric(deviation) || ~isscalar(deviation)  || isnan(deviation) || ~isreal(deviation))
                        disp("Not a valid input");
                        deviation = input(prompt);
                    end
                    
                    smoothedImage = imgaussfilt(noisyImage,deviation,'FilterSize',tamanho,'FilterDomain','spatial');
                    
                    
                    imwrite(smoothedImage,strcat(path,'_smooth_gaussian_',num2str(tamanho),'_',num2str(deviation),'.png'));
                case '3'
                    
                    prompt = 'Enter the size of the filter to apply\n';
                    tamanho = input(prompt);
                    while(~isnumeric(tamanho) || ~isscalar(tamanho)  || isnan(tamanho) || ~isreal(tamanho))
                        disp("Not a valid input");
                        tamanho = input(prompt);
                    end
                    
                    smoothedImage = medfilt2(noisyImage,[tamanho tamanho]);%Ainda da para especificar o padding
                    
                    imwrite(smoothedImage,strcat(path,'_smooth_median_',num2str(tamanho),'.png'));
                  
                otherwise
                    loop=1;
                    disp("Not a valid input");
                    smoothing = input(prompt);
            end
        end
    case '2'
        domain = 'frequency';
        disp(domain + " domain chosen" );
        
        prompt = 'Choose type of smoothing\n1-Gaussian\n2-Butterworth\n';
        smoothing = input(prompt,'s');
        loop = 1;
        while loop
            loop = 0;
            switch smoothing
                case '1'
                case '2'
                otherwise
                    loop = 1;
                    disp("Not a valid input");
                    smoothing = input(prompt);
            end
        end
end
   

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

FI=fft2(img);
figure(1);
imshow((FI));
FN=fft2(noisyImage);
figure(2);
imshow((FN));
FS=fft2(smoothedImage);
figure(3);
imshow((FS));
%{
dft=fft2(img);
dft_of_dft=fft2(dft);


spectrum = abs(dft);
c = 255 / log(1 + max(spectrum(:)));
spectrum = c*log(spectrum);
double_dft_spectrum = abs(dft_of_dft);
c = 255 / log(1 + max(double_dft_spectrum(:)));
double_dft_spectrum = c*log(double_dft_spectrum);



figure(1);
imshow(spectrum);

figure(2);
imshow(double_dft_spectrum);
%}
end

