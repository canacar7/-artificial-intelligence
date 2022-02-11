%*
%matris gelen matris degeri"
%*
function [y] = sgm_fonk(matris)
[m,n] = size(matris);
%cikan degerler aktivasyon fonksiyonuna girer
for i = 1 : m
    for j = 1 : n
        matris(i,j) = 1 / (1 + exp (-matris(i,j)));
        j = j + 1;
    end
    i = + 1;
end
    y = matris;

end

