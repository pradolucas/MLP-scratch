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
## @deftypefn {} {@var{retval} =} med_channels (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-02

function [F10m, F11m, F12m, F13m] = med_channels (N, num_of_chans, data_is_empty, F_dez, F_onze, F_doze, F_treze, show_time)
  #{ 
  args: [Nsam,Nchan,Ntrial], ncanais(apos selecao de canais), Features10(Trials x N_classes), Features11(Trials x N_classes), Features12(Trials x N_classes), Features13(Trials x N_classes)
  #} 
  if show_time 
    tic;
    disp("")
    disp("Iniciando Media dos canais")
  endif
  N_classes = 4-sum(data_is_empty); 
  ####MEDIA DOS CANAIS
  F10m=zeros(12,N_classes);
  F11m=zeros(12,N_classes);
  F12m=zeros(12,N_classes);
  F13m=zeros(12,N_classes);
  
  for ii=1:(N(3)/(4))
    for pp=1:N_classes:(num_of_chans*N_classes)
      for  nn = 1:N_classes
        if !data_is_empty(1)
           F10m(ii,nn)= F10m(ii,nn) + F_dez(ii,pp+nn-1); 
        endif
        if !data_is_empty(2)
           F11m(ii,nn)= F11m(ii,nn) + F_onze(ii,pp+nn-1);
        endif    
        if !data_is_empty(3)
            F12m(ii,nn)= F12m(ii,nn) + F_doze(ii,pp+nn-1);
        endif         
        if !data_is_empty(4)
            F13m(ii,nn)= F13m(ii,nn) + F_treze(ii,pp+nn-1);
        endif
      endfor 
      
    endfor
  endfor

  F10m=F10m/num_of_chans;
  F11m=F11m/num_of_chans;
  F12m=F12m/num_of_chans;
  F13m=F13m/num_of_chans;
  if show_time 
    toc;
    disp("Fim Media dos canais")
    disp("")
  endif
endfunction
