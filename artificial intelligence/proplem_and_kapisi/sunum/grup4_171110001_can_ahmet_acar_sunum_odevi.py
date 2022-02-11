    
    """Giriş katmanı ile ara katman arasındaki ağırlıklar 
       Birinci ara katman ile ikinci ara katman arasındaki ağırlıklar 
       İkinci ara katman ile çıkış katmanı arasındaki ağırlıklar 
       I. esik degeri
       II. esik degeri
       III. esik degeri
       beklenen durumlar
       A2_C(t - 1)
       B3_C(t - 1)
       A1_A2(t - 1)
       B2_C(t - 1)
       A1_C(t - 1)
       B1_C(t - 1)
       ogrenme katsayisi"""
    import numpy as np
    import math  as mt
    
    
    "fonksiyon tanimlamalari"
    "*"
    "matris gelen matris degeri"
    "*"
    "*************************************************************************"
    def step_fonk(matris):
        (m,n) = matris.shape;
        for i in range(m):
            for j in range(n):
                if(matris[i,j] >= 0):
                    matris[i,j] = 1;
                else:
                    matris[i,j] = 0;
                j = j + 1;
            i = i +1;
                    
        return matris;
    """*
    "matris gelen matris degeri"
    "*
    "*************************************************************************"""
    def sgm_fonk(matris):
        m = len(matris);
        for i in range(m):
               matris[i] = 1 / (1 + mt.exp(-matris[i]));
               i = i + 1;
                               
        return matris;
    "*************************************************************************"
    def sgm_trv_fonk(matris):
        m = len(matris);
        for i in range(m):
            matris[i] = matris[i] * (1 - matris[i]);
            i = i + 1;
                               
        return matris;
    """*
    "At_0 ------- Agirlik degerlerinin (t - 1)
    "At_1 ------- Agirlik degerlerinin (t)
    "At_2 ------- Agirlik degerlerinin (t + 1)
    "*
    "*************************************************************************"""
    def geri_yayilim_c(At_1,sigma,net,At_0):
        fi  = 0.9;
        mem = 0.1;                                                                                    
        At_2 = At_1 + (fi * sigma * net + mem * At_0);
        y = At_2;                 
        return y;
    """*
    "Bt_0 ------- Esik degerlerinin (t - 1)
    "Bt_1 ------- Esik degerlerinin (t)
    "Bt_2 ------- Esik degerlerinin (t + 1)
    "*
    "*************************************************************************"""
    def geri_yayilim_bc(Bt_1 ,sigma , Bt_0):
        fi  = 0.9;
        mem = 0.1;                                                                                      
        Bt_2 = Bt_1 + (fi * sigma + mem * Bt_0);
        y = Bt_2;                 
        return y;
    "*************************************************************************"
    
    "degisken tanimlamalari"
    
    GD               = np.array([[0.0, 0.0],                                        
                                [0.0, 1.0], 
                                [1.0 ,0.0], 
                                [1.0 ,1.0]]);   
                                                                     
    GK_A1            = np.array([[0.131 ,0.443, 0.624],
    				             [-0.347 ,-0.445 ,-0.127]]); 
    
    A1_A2            = np.array([[0.978, 0.956],
    					[0.724, -0.932], 
    				    [-0.946, 0.923 ]]);                                                                                                
    
    A2_C             = np.array([0.987 ,0.966]);                                                        
    B1               = np.array([0.526 ,0.513 ,0.552]);                                                   
    B2               = np.array([0.524 ,0.525]);                                                         
    B3               = np.array([0.574]);                                                               
    bk               = np.array([0.0 ,0.0, 0.0 ,1.0]);                                                             
    A2_C_O           = np.array([0 ,0]) ;                                                                
    B3_C_O   	     = np.array([0.0]);                                                                   
    A1_A2_O          = np.array([[0,0],[0,0],[0,0]] );                                                        
    B2_C_O   	     = np.array([0 ,0]);                                                                 
    GK_A1_O          = np.array([[0.0, 0.0, 0.0], [0.0 ,0.0 ,0.0]]) ;                                                       
    B1_C_O           = np.array([0.0, 0.0, 0.0]);                                                               
    fi               = 0.9 ;                                                                  
    mem          	 = 0.1;   
    E                = 0.0;
    
    
    
    
    iterasyon = 0;
    a  = 0;
    x  = 0;
    for x in range(1):
         
           while a < 4 :
               
               "ileri yayilim"
               print("iterasyon", iterasyon);
               iterasyon = iterasyon + 1;
               net_1 = np.dot(GD[a : a + 1, 0:2], GK_A1[0 : 3,0: 4 ]) + B1;
               print("net_1", net_1);
               net_1 = step_fonk(net_1);
               print("net_af", net_1);
               
               
               net_2 = np.dot(net_1,  A1_A2) + B2;
               print("net_2", net_2);
               net_2 = step_fonk(net_2);
               print("net_2_af", net_2);
               
               net_3 = np.dot(net_2,  A2_C.transpose()) + B3;
               print("net_3", net_3);
               net_3 = sgm_fonk(net_3);
               print("net_3_af", net_3);
               
               E = bk[a] - net_3;
               if(abs(E) < abs(0.01)):
                   print("hata yok \n");
                   a = a + 1;
               elif(abs(E) >=  abs(0.01)):
                   z = sgm_trv_fonk(net_3);
                   sigma = z * E;
                 
                   A2_C_Y     = geri_yayilim_c(A2_C,sigma,net_2,A2_C_O);
                   A2_C_O     = A2_C;
                   A2_C       = A2_C_Y;
                   print("a2_c_y \n");
                   print(A2_C_Y , A2_C_O ,A2_C ,"\n");
                   
                   B3_Y    = geri_yayilim_bc(B3 ,sigma , B3_C_O);
                   B3_C_O  = B3;
                   B3      = B3_Y;
                   print("b3_y \n");
                   print(B3_Y,B3_C_O, B3  ,"\n");
                   
                   A1_A2_Y     = geri_yayilim_c(A1_A2,sigma, net_1.transpose(),A1_A2_O );
                   A1_A2_O     = A1_A2;
                   A1_A2       = A1_A2_Y;
                   print("GK_A1_Y \n");
                   print(A1_A2_Y  ,"\n" , A1_A2_O  ,"\n" ,A1_A2 ,"\n" );
                   
                   B2_Y    = geri_yayilim_bc(B2 ,sigma , B2_C_O);
                   B2_C_O  = B2;
                   B2      = B2_Y;
                   print("b2y \n");
                   print(B2_Y, "\n" ,B2_C_O, "\n", B2,"\n");
                                                                                 
                   
                   GK_A1_Y     = geri_yayilim_c(GK_A1,sigma,GD[a : a + 1, ::].transpose(),GK_A1_O);
                   GK_A1_O     = GK_A1;
                   GK_A1       = GK_A1_Y;
                   print("GK_A1_Y \n");
                   print(GK_A1_Y ,"\n" , GK_A1_O ,"\n" ,GK_A1 ,"\n" );
                   
                   B1_Y    = geri_yayilim_bc(B1 ,sigma , B1_C_O);
                   B1_C_O  = B1;
                   B1      = B1_Y;
                   print("b1y \n");
                   print(B1_Y, "\n" ,B1_C_O, "\n", B1 ,"\n");
                        
                   a = 0;
                  
                 
               
    
    print("iterasyon =" , iterasyon);    
                  
    
    
                        
                    
            
    
    
    
    
    
    
    
    
    
    
    
    
    
    
