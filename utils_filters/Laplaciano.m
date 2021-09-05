## Copyright (C) 2020 Lucas
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} Laplaciano (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-11

function [data10, data11, data12, data13] = Laplaciano (X, N, labels, show_time)
##########FILTRO Laplaciano###############
   if show_time 
    tic;
    disp("")
    disp("Iniciando CAR")
  endif
  
  count_dez = 1;
  count_onze = 1;
  count_doze = 1;
  count_treze = 1;
  data10 = zeros (N (1), N (2), 12);
  data11 = zeros (N (1), N (2), 12);
  data12 = zeros (N (1), N (2), 12);
  data13 = zeros (N (1), N (2), 12);
  #ordem=[0 14 0; 15 12 13; 11 10 16; 7 8 9; 4 5 6; 2 1 3];
  ordem=[15 12 13; 11 10 16; 7 8 9; 4 5 6; 2 1 3];

  for trial=1:N(3)
    data=X(:,:,trial);
    data_laplacian=X(:,:,trial);
    
    hh=1;
    for(ii=1:5)#DESCONSIDERANDO O ELETRODO 14
      for(jj=1:3)
        sum=0;
        if (jj==1)#Primeira coluna 
          if (ii!=[1,5])#certo 
            sum=data(:,ordem(ii-1,jj))+data(:,ordem(ii+1,jj))-2*data(:,ordem(ii,jj+1))+data(:,ordem(ii,jj+2));
            data_laplacian(:,hh++)=sum-data(:,ordem(ii,jj));
          elseif (ii==1)#certo
            sum=-2*data(:,ordem(ii,jj+1))+data(:,ordem(ii,jj+2))-2*data(:,ordem(ii+1,jj))+data(:,ordem(ii+2,jj));
            data_laplacian(:,hh++)=2*data(:,ordem(ii,jj))+sum;
          else #certo
            sum=-2*data(:,ordem(ii-1,jj))+data(:,ordem(ii-2,jj))-2*data(:,ordem(ii,jj+1))+data(:,ordem(ii,jj+2));
            data_laplacian(:,hh++)=2*data(:,ordem(ii,jj))+sum;
          endif
        elseif (jj==2)#MEIO
          if (ii!=[1,5])#CERTO
            sum=data(:,ordem(ii-1,jj))+data(:,ordem(ii,jj-1))+data(:,ordem(ii,jj+1))+data(:,ordem(ii+1,jj));
            data_laplacian(:,hh++)=sum-4*data(:,ordem(ii,jj));
          elseif ii==1 #CERTO
            sum=data(:,ordem(ii,jj-1))+data(:,ordem(ii,jj+1))-2*data(:,ordem(ii+1,jj))+data(:,ordem(ii+2,jj));
            data_laplacian(:,hh++)=sum-data(:,ordem(ii,jj));
          else #certo
            sum=data(:,ordem(ii,jj-1))+data(:,ordem(ii,jj+1))-2*data(:,ordem(ii-1,jj))+data(:,ordem(ii-2,jj));
            data_laplacian(:,hh++)=sum-data(:,ordem(ii,jj));
          endif
        elseif (jj==3)
          if (ii!=[1,5])#CERTO
            sum=data(:,ordem(ii+1,jj))+data(:,ordem(ii-1,jj))-2*data(:,ordem(ii,jj-1))+data(:,ordem(ii,jj-2));
            data_laplacian(:,hh++)=sum-data(:,ordem(ii,jj));
          elseif ii==1#Certo
            sum=-2*data(:,ordem(ii,jj-1))+data(:,ordem(ii,jj-2))-2*data(:,ordem(ii+1,jj))+data(:,ordem(ii+2,jj));
            data_laplacian(:,hh++)=sum+2*data(:,ordem(ii,jj));
          else #certo
            sum=-2*data(:,ordem(ii,jj-1))+data(:,ordem(ii,jj-2))-2*data(:,ordem(ii-1,jj))+data(:,ordem(ii-2,jj));
            data_laplacian(:,hh++)=sum+2*data(:,ordem(ii,jj));
          endif
         endif
      endfor
    endfor
  
  %%%%Separador de freq
    if(labels(trial)==1)
      data10(:,:,count_dez++)=data_laplacian;  
    elseif(labels(trial)==2)
      data11(:,:,count_onze++)=data_laplacian;  
    elseif(labels(trial)==3)
      data12(:,:,count_doze++)=data_laplacian;
    elseif(labels(trial)==4)
      data13(:,:,count_treze++)=data_laplacian;
    endif 
  endfor
endfunction
