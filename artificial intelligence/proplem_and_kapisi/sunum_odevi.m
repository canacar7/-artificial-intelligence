GD                = [ 0 0; 0 1; 1 0; 1 1];                                                                        %durumların tanitilmasi
GK_A1         = [0.131 0.443 0.624; -0.347 -0.445 -0.127 ];                              %Giriş katmanı ile ara katman arasındaki ağırlıklar 
A1_A2          = [0.978 0.956; 0.724 -0.932; -0.946 0.923 ];       						  %Birinci ara katman ile ikinci ara katman arasındaki ağırlıklar 
A2_C            = [0.987 0.966] ;                                                                              %İkinci ara katman ile çıkış katmanı arasındaki ağırlıklar 
B1                 = [0.526 0.513 0.552];                                                                    % I. esik degeri
B2                 = [0.524 0.525];                                                                               % II. esik degeri
B3                 = [0.574];                                                                                          % III. esik degeri
bk                  = [0 0 0 1];                                                                                        %beklenen durumlar
A2_C_O       = [0 0] ;                                                                                             %A2_C(t - 1)
B3_C_O   	 = [0];                                                                                                 %B3_C(t - 1)
A1_A2_O     = [0 0;0 0;0 0] ;                                                                                %A1_A2(t - 1)
B2_C_O   	 = [0 0];                                                                                              %B2_C(t - 1)
GK_A1_O    = [0 0 0; 0 0 0] ;                                                                               %A1_C(t - 1)
B1_C_O       = [0 0 0];                                                                                           %B1_C(t - 1)
fi                    = 0.9 ;                                                                                                %ogrenme katsayisi
mem          	 = 0.1;                                                                                                 %momentum

a = 1;
  iterasyon = 0;

for sayici  = 0 : 2
            while a  < 5
                iterasyon = iterasyon + 1;
                
               %ileri yayilim
               net_1 = GD(a, 1 : 2) * GK_A1 +B1
               net_1 = step_fonk(net_1)

               net_2 = (net_1 * A1_A2) + B2
               net_2 = step_fonk(net_2)

               net_3 = (net_2 * (A2_C)') + B3
               net_3 = sgm_fonk(net_3)

              %hata kontrolu
              E = bk(a) - net_3
              
                if(abs(E) < abs(0.01))
                    fprintf('hata yok \n');
                    a = a + 1;
                else if(abs(E) >=  abs(0.01) )
                    z = sgm_trv_fonk(net_3);
                    sigma = z * E
                    
                    %geri yayilim ara_katman_2 - cikis
					A2_C_Y  = geri_yayilim_c(A2_C,sigma,net_2,A2_C_O)
					A2_C_O  = A2_C;
					A2_C       = A2_C_Y;

					B3_Y       =  geri_yayilim_bc(B3 ,sigma , B3_C_O)
					B3_C_O  = B3;
					B3            = B3_Y;

					 % ara_katman_1 - ara_katman_2
					A1_A2_Y  = geri_yayilim_c(A1_A2, sigma, (net_1)', A1_A2_O)
					A1_A2_O  = A1_A2;
					A1_A2       = A1_A2_Y;

					B2_Y       =  geri_yayilim_bc(B2 ,sigma , B2_C_O)
					B2_C_O  = B2;
					B2            = B2_Y;
					
					 % ara_katman_1 - ara_katman_2
					GK_A1_Y  = geri_yayilim_c(GK_A1, sigma, (GD(a, 1 : 2))',GK_A1_O)
					GK_A1_O  = GK_A1;
					GK_A1       = GK_A1_Y;

					B1_Y       =  geri_yayilim_bc(B1 ,sigma , B1_C_O)
					B1_C_O  = B1;
					B1            = B1_Y;

					 a = 1;
                                     
                    end     
        end
end
              a = 4; 
              GD(a, 1 : 2) 
              iterasyon
              
end