function [result] = cocodrilo(Array)
tic
%Para el especifico caso donde el Soduko esdel tipo:
%Array1 =
%
%     5     3     0     0     7     0     0     0     0
%     6     0     0     1     9     5     0     0     0
%     0     9     8     0     0     0     0     6     0
%     8     0     0     0     6     0     0     0     3
%     4     0     0     8     0     3     0     0     1
%     7     0     0     0     2     0     0     0     6
%     0     6     0     0     0     0     2     8     0
%     0     0     0     4     1     9     0     0     5
%     0     0     0     0     8     0     0     7     9


%Este especifico caso se resulve con 4 ciclos
%Se deja  fuera del ciclo la función que 
%genera la celda.
a = 0;
[Ce] = celda (Array);

while a < 4 
     a = a + 1;
     [XCA] = comp_ver_esp (Ce);  
     [Xcaa] = com_espacial_best(XCA);
     [Ce] = comp_hori (Xcaa);
     %a = 0;
     for es = 1:9
         for er = 1:9
             if length(Ce{es,er}) > 1
                % a = a + 1;
                 disp(a)
             end
         end   
     end   
     disp(Ce)
end  

[result] = comp_hori (Ce); 

%En la funcion celda, tomamos la matriz de 9*9 y la convertimos en celda,
%Genera para cada 0 una matriz con los posibles numeros que pudieran 
%posionarse ahí.
function [Ce] = celda(X)
Ce = num2cell(X);
B = [];
D = [];
for i = 1:9 %estamos trabajando los numeros hacia abajo
    for ij = 1:9
        B = [B,Ce{i,ij}];
    end  
   
    %B = [B,Ce{i,}]    
    for j = 1:9 %los 9 numeros hacia la derecha
      
        [C] =  exist_num(B);
        
        if Ce{i,j} == 0
            Ce{i,j} = C;
        end 
            
    end
    B = [];
    
end

function [C] = exist_num(B)

A = [1,2,3,4,5,6,7,8,9];
C =[];
count = 0;

 for ic = 1:9
     for jc = 1:9
         if A(ic)==B(jc)
             count = count + 1;
             
         end
           
     end
     
      if count == 0
          C = [C,A(ic)];
      end
      count = 0;

      
end
end
end
%******************************************************
%En a función comp_ver_esp(XCa) se compara la matriz de los posibles 
%numeros con los numeros ya existentes en la linea vertical.

function [XCa] = comp_ver_esp (XCa)
Aa = [];
Aaa = [];

for i = 1:9
    for j = 1:9
        
        if length(XCa{i,j}) >1
            
           Aa = XCa{i,j}; 
           
           Aaa = Aa;
          
               for jj = 1:9  
                   if length(XCa{jj,j})==1
                       
                       for ii = 1:length(Aa)
                           
                           if Aa(ii) == XCa{jj,j}
                               
                               Aaa(Aaa==Aa(ii)) = [];
                                      
                           end
                       
                       end    
                   end
               end
              
          XCa{i,j} = Aaa;
          
        end
        
        Aaa = [];
        Aa = [];
    end
end

end
%La función com_espacial_best, busca en la celda XCA, la primera matriz 
%mayor a 1, la compara espacialmente, dependiendo de su ubicación ejemplo:
%XCA {1,1}, seria comparado con tres casiilas horizontal y tres vertical 
% en total 9 casillas.
%*******************comp espac best************
%
function [XCA] = com_espacial_best(XCA)

A = [];
AA = [];
m = 0;
n = 0;
%count = 0;
for k = 1:3
    %m = m+3;
    for l = 1:3
       % n = n +3;
        for i = (m+1):(m+3) %(1,3)*3 / (4,6)*3 (7,9)*3
            for j = (n+1):(n+3) %(1,3-4,6-7,9) / (1,3-4,6-7,9) /(1,3-4,6-7,9)
                if length(XCA{i,j}) >1
                    A = XCA{i,j}; 
                    AA = A;
                    for jj = (1+m):(3+m)  %
                        for ii = (1+n):(3+n)  %
                            for iii = 1:length(A)
                                if length(XCA{jj,ii})==1
                                    if A(iii) == XCA{jj,ii}
                                       
                                        AA(AA==A(iii)) = [];
                                    end
                                end
                            end    
                        end
                    end
                XCA{i,j} = AA;
                end
            A = [];
            AA = [];
            end
          
        end
        n = n + 3;
    end
    n = 0;
    m = m + 3;
end    
           
end

%En la función comp_hori(XCaa) se compara la matriz de los posibles numeros
% con los numeros ya existentes en la linea horizontal.

function [XCaa] = comp_hori (XCaa)
Aah = [];
Aaah = [];

for ih = 1:9
    for jh = 1:9
        %disp(j)
        if length(XCaa{ih,jh}) >1
            
           Aah = XCaa{ih,jh}; %esta bien toma el primer cero de izquierda derecha
           
           Aaah = Aah;
           %for ii = 1:length(Aa)       %ciclo de comparacion
               for jjh = 1:9  % la tenemos que cambiar conforme avance i
                   if length(XCaa{ih,jjh})==1
                       
                       for iih = 1:length(Aah)
                           
                           if Aah(iih) == XCaa{ih,jjh}
                               
                               Aaah(Aaah==Aah(iih)) = [];
                              
                           end
                       
                       end    
                   end
               end
               
          XCaa{ih,jh} = Aaah;
         
        end
        Aaah = [];
        Aah = [];
    end
end
end
toc

