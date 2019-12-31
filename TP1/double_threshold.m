function [strong, weak] = double_threshold(Em,lt,ht)

[sx,sy]=size(Em);
strong = false(sx,sy);
weak = false(sx,sy);
for i = 1 : sx 
    for j = 1 : sy
        if(Em(i,j) >= ht)
            strong(i,j) = 1;
        elseif(Em(i,j) >= lt)
            weak(i,j) = 1;
        end
    end
end



end

