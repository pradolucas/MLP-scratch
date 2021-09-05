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
## @deftypefn {} {@var{retval} =} L_model_foward (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-03

function [AL, caches] = L_model_forward (X, parameters, lastLayer, allLayer)
 
    #{
    Implement forward propagation for the [ [LINEAR->RELU(ou outra)]*(L-1) ]->LINEAR->SIGMOID computation
    
    Arguments:
    X -- data, numpy array of shape (input size, number of examples)
    parameters -- output of initialize_parameters_deep()
    
    Returns:
    AL -- matrix last post-activation value
    caches -- list of caches containing:
                every cache of linear_activation_forward() (there are L-1 of them, indexed from 0 to L-1)
    #}
    caches = {};
    #cache = {}; 
    A = X;
    L = floor(numfields(parameters)/2);        # number of layers in the neural network
    
    for l = 1:L-1
      [A, cache] = linear_activation_forward(A, parameters.(strcat('W',mat2str(l))) , parameters.(strcat('b',mat2str(l))) , activation = allLayer);
      caches = cat(1, caches, reshape(cache,[1,2]));
    endfor
    
    # Implement LINEAR -> SIGMOID. Add "cache" to the "caches" list.
    [AL, cache] = linear_activation_forward(A, parameters.(strcat('W',mat2str(L))) , parameters.(strcat('b',mat2str(L))) , activation = lastLayer);
    caches = cat(1, caches, reshape(cache,[1,2])); %1x1 lin_values1, 1x2 activ_values1

    #AL.shape == (1,X.shape[1])
    
endfunction
