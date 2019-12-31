function [F] = blob(F,weak,i,j)

if(weak(i-1,j-1) && ~F(i-1,j-1))
    F(i-1,j-1) = 1;
    blob(F,weak,i-1,j-1);
elseif(weak(i-1,j) && ~F(i-1,j))
    F(i-1,j) = 1;
    blob(F,weak,i-1,j);
elseif(weak(i-1,j+1) && ~F(i-1,j+1))
    F(i-1,j+1) = 1;
    blob(F,weak,i-1,j+1);
elseif(weak(i,j-1) && ~F(i,j-1))
    F(i,j-1) = 1;
    blob(F,weak,i,j-1);
elseif(weak(i,j+1) && ~F(i,j+1))
    F(i,j+1) = 1;
    blob(F,weak,i,j+1);
elseif(weak(i+1,j-1) && ~F(i+1,j-1))
    F(i+1,j-1) = 1;
    blob(F,weak,i+1,j-1);
elseif(weak(i+1,j) && ~F(i+1,j))
    F(i+1,j) = 1;
    blob(F,weak,i+1,j);
elseif(weak(i+1,j+1) && ~F(i+1,j+1))
    F(i+1,j+1) = 1;
    blob(F,weak,i+1,j+1);
end
    

end

