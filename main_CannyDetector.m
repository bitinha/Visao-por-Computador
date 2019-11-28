function [Es,Em,Final] = main_CannyDetector(img,kernel_size,sigma,lt, ht)
figure;imshow(img);
    img = Gaussian_smoothing(img,kernel_size,sigma);
    figure;imshow(img);
    
    [Es,Eo] = gradient(img);
    figure;imshow(Es);
    Em = nonmax(Es,Eo);
    figure;imshow(Em);
    [strong,weak] = double_threshold(Em,lt,ht);
    
    Final = hysteresis_thresholding(strong,weak);

    figure;imshow(Final);

end

