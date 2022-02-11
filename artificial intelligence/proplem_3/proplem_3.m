clc;
clear;
clear all;
%soru
%-------------------------------------------------------------------------
% Turye icin ortalama boy - kilo erkeklerde 170cm - 185cm ve 64kg - 80kg, 
% kadınlarda ise 150cm - 170cm 50kg - 64kg dir. Bu aralikda ki degerler
% dikkate alinarak hesablama islemi gerceklestirilecektir.
% 2 girisli ve tek cikisli bir sinir hücre modelinin; giris parametreleri
% bir insanin kg cinsinden ve cm cinsinden boyunu ifade etmekdedir. Bu
% hücre modeli ile birlikte verilen sinaptik agirliklar, bias ve aktivasyon
% fonksiyonu ile; girişte verilen parametreler dogrultusunda erkek veya
% kadin olma durumlari analiz edilmiştir. 
% kg cinsinden agirlik icin 1. giris parameteresine karsilik gelen sinaptik
% agirlik w1 = 10
% cm cinsinden uzunluk icin 2. giris parameteresine karsilik gelen sinaptik
% agirlik w2 = 100
% dis parametereye karsilik gelen sinaptik agirlik w0 = 60, giris = +1,
% esik degeri bk = 60 dir.
% ogrenme parametresi fi = 0.01
% aktivasyon fonksiyonu vk >= 8220 ise 1 erkek 
% aktivasyon fonksiyonu vk < 8220 ise -1 kadın
%durumların tanitilmasi
%------------------------------------------------------------------------
%D = [ 64 169] ;
D = [64 170];
W = [-10; 100];
bk = 60;
vk = D*W+bk;
if(vk >= 16420)
 a_f = 1;
elseif(vk < 16420) 
 a_f = -1;
end
fprintf("vk %d \n", vk);
if(a_f == 1)
 fprintf('aktivasyon fonksiyonu = %d\n', a_f );
 fprintf('girilen parametreler sonucunda kisi erkekdir \n');
elseif(a_f == -1)
 fprintf('aktivasyon fonksiyonu = %d ve \n', a_f );
 fprintf('girilen parametreler sonucunda kisi kadindir \n');
end
func='logsig';
y=logsig(vk);
[D1,D2]=meshgrid(0:1:160);
z=feval(func,[D1(:) D2(:)]*W+bk);
z=reshape(z,length(D1),length(D2));
plot3(D1,D2,z);

xlabel('D1 in girişi = ağırlık(gr)');
ylabel('D2 in girişi = uzunluk(cm)');
zlabel('y in girişi = çıkışı');