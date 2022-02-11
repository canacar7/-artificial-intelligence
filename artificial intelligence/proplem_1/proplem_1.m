%Okul yemekhsanesinde vejeteryan ve normal menü çıkmaktadır. 
% Yemekhanede
% %yemeklerin alınma durumuna göre vejeteryan menüden veya 
% normal menüden
% %alimi kayit altinda tutmak icin model olusturulmasi
% gerekmektedir. Normal
% %menü alanlar durumu N[1,0] cikis = 1, vejeteryan menü alanlar 
% ise V=[0,1]
% %cikis = -1 dir. Model icin kullanici tarafindan belirlenen 
% parametreler
% %alinarak ogrenme modeli olusturulsun ? 
% %Aktivasyon fonksiyonu: net >= 0 ise 1, net<0 ise -1
clc;
clear;
clear all;
beklenen_cikti_normal = 1;
beklenen_cikti_vejeteryan = -1;
N = [1 0];
V = [0 1];
w1 = input ('Birinci ağırlık değeri (w1): '); 
w2 = input ('İkinci ağırlık değeri (w2): ');
a = input ('Öğrenme katsayısı(a): ');
ed = input ('esik değeri (es): ');
fprintf('girilen değerler: w1:%f w2:%f a:%f ed:%f \n ',w1,w2,a,ed);
for(i = 0: 1: 5)
 
%-------------------------------------------------------------%
net_n = w1 * N(1,1) + w2 * N(1,2) + ed;
fprintf('net_n :%f \n' , net_n);
if(net_n >= 0)
 gercek_cikti_normal = 1;
 fprintf('gercek_cikti ve beklenen cikti saglanmistir \n');
else
 gercek_cikti_normal = -1;
end
%-------------------------------------------------------------%
net_v = w1 * V(1,1) + w2 * V(1,2) + ed;
fprintf('net_v :%f \n' , net_v);
if(net_v < 0)
 gercek_cikti_vejeteryan = -1;
 fprintf('gercek_cikti ve beklenen cikti saglanmistir \n'); 
else
 gercek_cikti_vejeteryan = 1;
end
%--------------------------------------------------------------%
if(gercek_cikti_normal == -1)
 fprintf('gercek_cikti ve beklenen cikti saglanamamistir, agirlik ve esik degerleri tekrar bulunur \n'); 
 E = beklenen_cikti_normal - (gercek_cikti_normal);
 w1_yeni = w1 + a * E * N(1,1);
 w1 = w1_yeni;
 w2_yeni = w2 + a * E * N(1,2);
 w2 = w2_yeni;
 ed_yeni = ed + a * E;
 ed = ed_yeni;
end
if(gercek_cikti_vejeteryan == 1)

 fprintf('gercek_cikti ve beklenen cikti saglanamamistir, agirlik ve esik degerleri tekrar bulunur \n'); 
 E = beklenen_cikti_vejeteryan - (gercek_cikti_vejeteryan);
 w1_yeni = w1 + a * E * V(1,1);
 w1 = w1_yeni;
 
 w2_yeni = w2 + a * E * V(1,2);
 w2 = w2_yeni;
 ed_yeni = ed + a * E;
 ed = ed_yeni;
end
end
fprintf('bulunan değerler: w1:%f w2:%f a:%f ed:%f ',w1,w2,a,ed);