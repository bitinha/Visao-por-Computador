function []=smoothfilters(path)

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
        while(~isnumeric(mean) || ~isscalar(mean) || isnan(mean) || isreal(mean))
            disp("Not a valid input");
            mean = input(prompt);
        end
        prompt = 'Enter a variance for the noise\n';
        variance = input(prompt);
        while(~isnumeric(variance) || ~isscalar(variance)  || isnan(variance) || isreal(variance))
            disp("Not a valid input");
            variance = input(prompt);
        end
    case '2'
        noise = 'salt & pepper';
        disp(noise + " noise chosen" );
        prompt = 'Enter the noise density\n';
        density = input(prompt);
        while(~isnumeric(density) || ~isscalar(density)  || isnan(density) || isreal(density))
            disp("Not a valid input");
            density = input(prompt);
        end
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
        smoothing = input(prompt,s);
        loop = 1;
        while loop
            loop = 0;
            switch smoothing
                case '1'
                case '2'
                case '3'
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
        smoothing = input(prompt,s);
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