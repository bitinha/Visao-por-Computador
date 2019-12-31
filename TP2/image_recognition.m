


path='Imagens/coins3.jpg';
Imagem = imread(path);
[~, ~, numberOfColorChannels] = size(Imagem);
if(numberOfColorChannels==3)
    Imagem = rgb2gray(Imagem);
end
gray_path = strcat(path,'gray','.png');
imwrite(Imagem,gray_path);

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
   
centers = main_image_recognition(gray_path,noise,noiseParameters);


