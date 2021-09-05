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
## @deftypefn {} {@var{retval} =} Ext_Feature (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-02

function [F_dez, F_onze, F_doze, F_treze, num_of_chans, data_is_empty] = Ext_Feature (N, fs, data10, data11, data12, data13, show_time, v)  
  #{ 
  args: [Nsam,Nchan,Ntrial], freq_amostragem, Data10_filtrado, Data11_filtrado, Data12_filtrado, Data13_filtrado, canais fora
  #} 
  if show_time 
    tic;
    disp("")
    disp("Iniciando Extração de Features")
  endif
  
  N_classes = 0;
  n = []; 
  data_is_empty = [];
  
  for ii=10:13
    if  eval(sprintf("!isempty(%s)", strcat('data',mat2str(ii))))
      Fq = ii;
      n_valido = (N(1)/fs)*Fq+1;
      n = cat(2, n,n_valido);
      data_is_empty = cat(2, data_is_empty, false);
    else 
      data_is_empty = cat(2, data_is_empty, true);
    endif
  endfor
  N_classes = 4 - sum(data_is_empty);
  ##data_is_empty
  
  if v==0
    v = [1 2 3 4 10 14 15 16];%canais que n?o gostei
  endif
  #v=[];  #Dois V somente para dizer que não há nenhum canal retirado
  num_of_chans=N(2)-length(v);%tirando os canail que n?o gostei
  #v=0;
##  N_classes

  F_dez=zeros(12,num_of_chans*N_classes);%vetor de trial por (canais*classes)
  F_onze=zeros(12,num_of_chans*N_classes);
  F_doze=zeros(12,num_of_chans*N_classes);
  F_treze=zeros(12,num_of_chans*N_classes);

   for trial=1:12
    Chans_XY=1;
    for chans=1:N(2)
      if(chans!=v(:,:))
        for  ii = 1:N_classes %Mudar columns(n) para N_classes
          if !data_is_empty(1)
            a=(abs(fft(data10(:,chans,trial))));
            F_dez(trial,Chans_XY)=a(n(ii),1);
          endif
          if !data_is_empty(2)
            b=(abs(fft(data11(:,chans,trial))));
            F_onze(trial,Chans_XY)=b(n(ii),1);
          endif    
          if !data_is_empty(3)
            c=(abs(fft(data12(:,chans,trial))));
            F_doze(trial,Chans_XY)=c(n(ii),1);   
          endif         
          if !data_is_empty(4)
            d=(abs(fft(data13(:,chans,trial))));
            F_treze(trial,Chans_XY)=d(n(ii),1);
          endif
          Chans_XY++;
        endfor
      endif
    endfor
   endfor
   
  if show_time 
    toc;
    disp("Fim Extração de Features")
    disp("")
  endif
endfunction

##          F_dez(trial,Chans_XY+1)=a(n(2),1);
##          F_dez(trial,Chans_XY+2)=a(n(3),1);
##          F_dez(trial,Chans_XY+3)=a(n(4),1); 
##          
##          F_onze(trial,Chans_XY+1)=b(n(2),1);
##          F_onze(trial,Chans_XY+2)=b(n(3),1);
##          F_onze(trial,Chans_XY+3)=b(n(4),1); 
##          
##          F_doze(trial,Chans_XY+1)=c(n(2),1);
##          F_doze(trial,Chans_XY+2)=c(n(3),1);
##          F_doze(trial,Chans_XY+3)=c(n(4),1); 
##          
##          F_treze(trial,Chans_XY+1)=d(n(2),1);
##          F_treze(trial,Chans_XY+2)=d(n(3),1);
##          F_treze(trial,Chans_XY+3)=c(n(4),1);