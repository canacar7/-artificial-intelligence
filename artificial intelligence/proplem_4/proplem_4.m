clc;clear;close;
GD = [-10; 10; 15]; %durumların tanitilmasi
GD_GK = [1;1;1]; %Girişler ile giriş katmanındaki ağırlıklar 
GK_A1 = [1 -10 -20; 10 20 15; -7 4 5;-1 6 -2 ]; %Giriş katmanı ile ara katman arasındaki ağırlıklar 
A1_A2 = [1 0 1 1;-1 1 2 -2; 0 0 -3 4 ]; %Birinci ara katman ile ikinci ara katman arasındaki ağırlıklar 
A2_C = [-1, 6, -9] ; %İkinci ara katman ile çıkış katmanı 
% arasındaki ağırlıklar 
%durumlar ile giris katmanin carpilamasi
%herhangi bir aktivasyon fonksiyonu bu katmanda bulunmamaktadir 
%giris ile cikan deger esittir.
sonuc_1 = GD .* GD_GK
%giris katmani ile ara katman 1 in carpilmasi
sonuc_2 = GK_A1 * sonuc_1
[m,n] = size(sonuc_2);
%cikan degerler aktivasyon fonksiyonuna girer
for i =1 : m
 net = sonuc_2(i,n);
 if(net >= 0)
 sonuc_2(i,n) = 1;
 elseif(net < 0)
 sonuc_2(i,n) = 0;
 end
end
sonuc_2
%birinci ara katmanin sonucu ile ikinci ara katmana girilir
sonuc_3 = A1_A2 *sonuc_2
[m,n] = size(sonuc_3);
%cikan degerler aktivasyon fonksiyonuna girer
for i =1 : m
 net = sonuc_3(i,n);
 if(net >= 0)
 sonuc_3(i,n) = 1;
 elseif(net < 0)
 sonuc_3(i,n) = 0;
 end
end
sonuc_3


%2 ara katmanin sonucu ile cikis katmanina girilir
sonuc_4 = A2_C * sonuc_3
[m,n] = size(sonuc_4);
for i =1 : m
 net = sonuc_4(i,n);
 if(net <= -10)
 sonuc_4(i,n) = -1;
 fprintf('sonuc elma')
 elseif(net >-10 && net <= 10)
 sonuc_4(i,n) = 0;
 fprintf('sonuc armut')
 elseif(net >10 )
 sonuc_4(i,n) = 1;
 fprintf('sonuc muz')
 end
end