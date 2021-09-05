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
## @deftypefn {} {@var{retval} =} init_parameters (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-03

function parameters = initialize_parameters (layer_dims, initialization)
  #{
  Argument:
  layer_dims -- array (list) containing the dimensions of each layer in our network

  Returns:
  parameters -- octave struct containing your parameters "W1", "b1", ..., "WL", "bL":
                Wl -- weight matrix of shape (layer_dims[l], layer_dims[l-1])
                bl -- bias vector of shape (layer_dims[l], 1)
  #} 
  parameters = struct();

  if strcmp(initialization, 'random')
    for l = 2:length(layer_dims)
      parameters.(strcat('W',mat2str(l-1))) = rand(layer_dims(l),layer_dims(l-1))*0.01;
      parameters.(strcat('b',mat2str(l-1))) = zeros(layer_dims(l),1);
    endfor
    
  elseif strcmp(initialization, 'xavier')
    for l = 2:length(layer_dims)
      parameters.(strcat('W',mat2str(l-1))) = rand(layer_dims(l),layer_dims(l-1))* sqrt(1/layer_dims(l-1));
      parameters.(strcat('b',mat2str(l-1))) = zeros(layer_dims(l),1);
    endfor
  endif

endfunction

