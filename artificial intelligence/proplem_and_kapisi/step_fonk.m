%*
%matris gelen matris degeri"
%*

function [y] = step_fonk(matris)
[m,n] = size(matris);
%cikan degerler aktivasyon fonksiyonuna girer
for i = 1 : m
    for j = 1 : n
    if(matris(i,j) >= 0)
        matris(i,j) = 1;
    else
        matris(i ,j) = 0;    
    end
    j = j + 1;
    end
    i = + 1;
end
    y = matris;

end

