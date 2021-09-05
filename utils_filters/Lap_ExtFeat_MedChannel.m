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
## @deftypefn {} {@var{retval} =} Lap_ExtFeat_MedChannel (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-11

function F_all_med = Lap_ExtFeat_MedChannel (stimuliData, N, label, show_time)
  #Extrai dos 4 canais
  [data10, data11, data12, data13] =  Laplaciano(stimuliData, N, label, show_time);
  [F_dez, F_onze, F_doze, F_treze, num_of_chans, data_is_empty] = Ext_Feature(N, 256, data10, data11, data12, data13, show_time);
  [F10m, F11m , F12m, F13m] = med_channels (N, num_of_chans, data_is_empty, F_dez, F_onze, F_doze , F_treze, show_time);
  F_all_med=[F10m;F11m;F12m;F13m];
  
endfunction
