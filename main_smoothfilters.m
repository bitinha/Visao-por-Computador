function [] = main_smoothfilters(img,path)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here



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
        imwrite(noisyImage,path+"_"+noise+"_"+mean+"_"+variance+".png");
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
        imwrite(noisyImage,path+"_"+noise+"_"+density+".png");
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
                    size = input(prompt);
                    while(~isnumeric(size) || ~isscalar(size)  || isnan(size) || ~isreal(size))
                        disp("Not a valid input");
                        size = input(prompt);
                    end
                    
                    filter = fspecial('average',size);
                    smoothedImage = imfilter(noisyImage,filter);
                    
                    imwrite(smoothedImage,path+"_smooth_average_"+size+".png");
                    
                case '2'
                    prompt = 'Enter the size of the filter to apply\n';
                    size = input(prompt);
                    while(~isnumeric(size) || ~isscalar(size)  || isnan(size) || ~isreal(size))
                        disp("Not a valid input");
                        size = input(prompt);
                    end
                    prompt = 'Enter the deviation of the filter to apply\n';
                    deviation = input(prompt);
                    while(~isnumeric(deviation) || ~isscalar(deviation)  || isnan(deviation) || ~isreal(deviation))
                        disp("Not a valid input");
                        deviation = input(prompt);
                    end
                    
                    smoothedImage = imgaussfilt(noisyImage,deviation,'FilterSize',size,'FilterDomain','spatial');
                    
                    
                    imwrite(smoothedImage,path+"_smooth_gaussian_"+size+"_"+deviation+".png");
                case '3'
                    
                    prompt = 'Enter the size of the filter to apply\n';
                    size = input(prompt);
                    while(~isnumeric(size) || ~isscalar(size)  || isnan(size) || ~isreal(size))
                        disp("Not a valid input");
                        size = input(prompt);
                    end
                    
                    smoothedImage = medfilt2(noisyImage,[size size]);%Ainda da para especificar o padding
                    
                    imwrite(smoothedImage,path+"_smooth_median_"+size+".png");
                  
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
   


end

