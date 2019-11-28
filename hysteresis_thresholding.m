function [out] = hysteresis_thresholding(strong,weak)


[sx,sy]=size(strong);
out = false(sx,sy);
for i = 2 : sx - 1
    for j = 2 : sy - 1
        if(strong(i,j))
            out(i,j) =1;
        end
        if(strong(i,j) && any(any(weak(i-1:i+1,j-1:j+1))))
            out = blob(out,weak,i,j);
        end
    end
end


end

