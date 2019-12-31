function [Es,Eo] = gradient(img)

[sx,sy] = size(img);

Zh = [-1 -2 -1;
       0  0  0;
       1  2  1];
Zv = [ -1  0  1;
       -2  0  2;
       -1  0  1];

   Es = zeros(sx,sy);
   Eo = zeros(sx,sy);
   for i = 2:(sx-1)
       for j = 2:(sy-1)
           pixeis = double(img(i-1:i+1,j-1:j+1));
           x=sum(sum(Zh.*pixeis));
           y=sum(sum(Zv.*pixeis));
           Es(i,j) = uint8(sqrt(x.^2+y.^2));
           
           Eo(i,j) = rad2deg(atan2(y,x));
           
       end
   end
   
   
   
   Es = uint8(Es);
end

