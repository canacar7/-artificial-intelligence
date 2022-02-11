%*
%"Bt_0 ------- Esik degerlerinin (t - 1)
%"Bt_1 ------- Esik degerlerinin (t)
% "Bt_2 ------- Esik degerlerinin (t + 1)
%*
function [y] = geri_yayilim_bc(Bt_1 ,sigma , Bt_0)

fi                    = 0.9 ;                                                                                               %ogrenme katsayisi
mem          	 = 0.1;                                                                                                 %momentum
Bt_2 = Bt_1 + (fi * sigma   + mem * Bt_0);
y = Bt_2 ;
end