
path='man.png';
Imagem = imread(path);
[~, ~, numberOfColorChannels] = size(Imagem);
if(numberOfColorChannels==3)
    Imagem = rgb2gray(Imagem);
end

%%%%%%%%% Recolha do tipo de ruido %%%%%%%%


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
        noiseParameters = [mean variance];
    case '2'
        noise = 'salt & pepper';
        disp(noise + " noise chosen" );
        prompt = 'Enter the noise density\n';
        density = input(prompt);
        while(~isnumeric(density) || ~isscalar(density)  || isnan(density) || ~isreal(density))
            disp("Not a valid input");
            density = input(prompt);
        end
        noiseParameters = density;
end
   

%%%%%%%%% Recolha do tipo de suavização %%%%%%%%


prompt = 'Choose filtering domain\n1-Spatial\n2-Frequency\n';
filter_domain = input(prompt,'s');

while(filter_domain ~= '1' && filter_domain ~= '2')
    filter_domain = input(prompt,'s');
end

switch filter_domain
    case '1'
        filter_domain = 'spatial';
        disp(filter_domain + " domain chosen" );
        prompt = 'Choose type of smoothing\n1-Average\n2-Gaussian\n3-Median\n';
        smoothing = input(prompt,'s');
        loop = 1;
        while loop
            loop = 0;
            switch smoothing
                case '1'
                    filterType = 'average';
                    prompt = 'Enter the size of the filter to apply\n';
                    tamanho = input(prompt);
                    while(~isnumeric(tamanho) || ~isscalar(tamanho)  || isnan(tamanho) || ~isreal(tamanho))
                        disp("Not a valid input");
                        tamanho = input(prompt);
                    end
                    
                    filterParameters = tamanho;
                case '2'
                    filterType = 'gaussian';
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
                    
                    filterParameters = [tamanho deviation];
                
                case '3'
                    
                    filterType = 'median';
                    prompt = 'Enter the size of the filter to apply\n';
                    tamanho = input(prompt);
                    while(~isnumeric(tamanho) || ~isscalar(tamanho)  || isnan(tamanho) || ~isreal(tamanho))
                        disp("Not a valid input");
                        tamanho = input(prompt);
                    end
                    
                    filterParameters = tamanho;
                    
                otherwise
                    loop=1;
                    disp("Not a valid input");
                    smoothing = input(prompt);
            end
        end
    case '2'
        filter_domain = 'frequency';
        disp(filter_domain + " domain chosen" );
        
        prompt = 'Choose type of smoothing\n1-Gaussian\n2-Butterworth\n';
        smoothing = input(prompt,'s');
        prompt = 'Choose cutoff frequency\n';
        cf = input(prompt,'s');
        loop = 1;
        while loop
            loop = 0;
            switch smoothing
                case '1'
                    filterType='gaussian';
                    filterParameters = cf;
                case '2'
                    filterType='butterworth';
                    prompt = 'Enter the filter order\n';
                    fo = input(prompt);
                    while(~isnumeric(fo) || ~isscalar(fo)  || isnan(fo) || ~isreal(fo))
                        disp("Not a valid input");
                        fo = input(prompt);
                    end
                    filterParameters = [cf fo];
                    
                otherwise
                    loop = 1;
                    disp("Not a valid input");
                    smoothing = input(prompt);
            end
        end
end
   
tic;
[noisyImage,smoothedImage]=main_smoothfilters(Imagem,noise,noiseParameters,filter_domain,filterType,filterParameters);     
toc;

if strcmp(noise, 'gaussian')
    imwrite(noisyImage,strcat(path,'_',noise,'_',num2str(noiseParameters(1)),'_',num2str(noiseParameters(2)),'.png'));
else
    imwrite(noisyImage,strcat(path,'_',noise,'_',num2str(noiseParameters(1)),'.png'));
end




if strcmp(filter_domain,'spatial')
    if strcmp(filterType,'average')

        imwrite(smoothedImage,strcat(path,'_smooth_average_',num2str(filterParameters),'.png'));    

    elseif strcmp(filterType,'gaussian')
        imwrite(smoothedImage,strcat(path,'_smooth_gaussian_',num2str(filterParameters(1)),'_',num2str(filterParameters(2)),'.png'));
    else
        imwrite(smoothedImage,strcat(path,'_smooth_median_',num2str(filterParameters(1)),'.png'));
    end
else
    if strcmp(filterType,'') % ButterWorth
        imwrite(smoothedImage,strcat(path,'_smooth_frequency_butterworth_',num2str(filterParameters(1)),'_',num2str(filterParameters(2)),'.png'));
    else %Gaussiano
        imwrite(smoothedImage,strcat(path,'_smooth_frequency_gaussian_',num2str(filterParameters(1)),'.png'));
    end
end
    

figure;
imshow(noisyImage);
figure;
imshow(smoothedImage);

