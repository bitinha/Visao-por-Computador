function [out] = Gaussian_smoothing(img,kernel_size,sigma)

out=imgaussfilt(img,sigma,'FilterSize',kernel_size,'FilterDomain','spatial');


end

