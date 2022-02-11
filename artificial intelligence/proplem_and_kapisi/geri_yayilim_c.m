%*
%At_0 ------- Agirlik degerlerinin (t - 1)
%At_1 ------- Agirlik degerlerinin (t)
%At_2 ------- Agirlik degerlerinin (t + 1)
%*
function [y] = geri_yayilim_c(At_1,sigma,net,At_0)

fi                    = 0.9 ;                                                                                               %ogrenme katsayisi
mem          	 = 0.1;                                                                                                 %momentum
At_2 = At_1 + (fi .* sigma  .* net + mem .* At_0);
y = At_2;

end