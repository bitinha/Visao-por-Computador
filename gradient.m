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
           x=sum(sum(Zh.*pixeis)).^2;
           y=sum(sum(Zv.*pixeis)).^2;
           Es(i,j) = uint8(sqrt(x+y));
           
           Eo(i,j) = atan2(y,x);
           
           %{
            if(Es(i,j)<200)
               Es(i,j) = 0;
           else
               Es(i,j) = 255;
           end
           %}
       end
   end
   
   
   
   Es = uint8(Es);
   figure(1);
   imshow(Es);
   figure(2);
   imshow(Eo);

end

