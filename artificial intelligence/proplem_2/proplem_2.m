clc;
clear;
clear all;
%durumların tanitilmasi
%------------------------------------------------------------------------
B = [1 0 0; %duzgun olmasi
 0 1 0; %hatali olmasi
 0 0 1]; %kirik olmasi
 
 
beklenen_durumlar = [1 0.5 0]; %beklenen durumlarin sirayla ciktilari
%agirlik, esik ve ogrenme katsayilerinin tanitilmasi
%------------------------------------------------------------------------
W = [0.5 0.4 0.5];
fi = 0.1;
a = 0.3;
i = 1;
for sayici = 0 : 2
 
 while i < 4
 net = W(1,1)*B(i,1) + W(1,2)*B(i,2) + W(1,3)*B(i,3) +fi;
 fprintf('net : %f \n' , net);
 if(net > 0.5)
 net = 1;
 elseif(net == 0.5)
 net = 0.5;
 elseif(net < 0.5)
 net = 0; 
 end
 E = beklenen_durumlar(i) - net;
 fprintf('E : %f \n' , E);
 if(E ~= 0) %esit degilse 0 a hatali durum
 fprintf('yeni degerler hesaplaniyor\n');
 fi = fi + a * E; 
 for j = 1: 3
 W(1,j) = W(1,j) + a * E * B(i,j); 
 end
 fprintf('bulunan değerler: w1:%f w2:%f w3:%f fi:%f \n' ,W(1,1),W(1,2),W(1,3),fi);
 i = 1;
 
 elseif (E == 0)
 fprintf('hata yok \n');
 i = i + 1;
 end 
 
 end
end
fprintf('bulunan yeni değerler: w1:%f w2:%f w3:%f fi:%f \n' ,W(1,1),W(1,2),W(1,3),fi);