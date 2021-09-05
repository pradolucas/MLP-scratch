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
## @deftypefn {} {@var{retval} =} L_model_backward (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-03

function grads = L_model_backward(AL, Y, caches, lastLayer, allLayer, error_type)
  #{
  Implement the backward propagation for the [LINEAR->RELU] * (L-1) -> LINEAR -> SIGMOID group
    
    Arguments:
    AL -- probability vector, output of the forward propagation (L_model_forward())
    Y -- true "label" vector (containing 0 if non-cat, 1 if cat)(1,m_training)
    caches -- list of caches containing:
                every cache of linear_activation_forward() with "relu" (it's caches[l], for l in range(L-1) i.e l = 0...L-2)
                the cache of linear_activation_forward() with "sigmoid" (it's caches[L-1])
    
    Returns:
    grads -- A dictionary with the gradients
             grads["dA" + str(l)] = ... 
             grads["dW" + str(l)] = ...
             grads["db" + str(l)] = ... 
  #}

  grads = struct();
  L = size(caches)(1); # the number of layers
  m = size(AL)(2);
  Y = reshape(Y, size(AL)); # after this line, Y is the same shape as AL
  
  # Initializing the backpropagation
  if strcmp(error_type, 'Log')
    dAL = - ((Y./AL) -((1 - Y)./(1 - AL))); # derivative of cost with respect to A
      ## Dá problema quando AL tende à 1
  elseif strcmp(error_type, 'CrossEntropy')
      AL;
    dAL = - (Y.*(AL.^-1)); #
  endif
  
  # Lth layer (SIGMOID -> LINEAR) gradients. 
  #Inputs: "dAL, current_cache". Outputs: "grads["dAL-1"], grads["dWL"], grads["dbL"]
  current_cache = caches(L,:); #L=3, A^L
  [grads.(strcat('dA',mat2str(L-1))), grads.(strcat('dW',mat2str(L))), grads.(strcat('db',mat2str(L)))] = linear_activation_backward(dAL, current_cache, activation = lastLayer, Y);
  
  # Loop from l=L-2 to l=0
  for l=(L-1):-1:1
    # lth layer: (RELU -> LINEAR) gradients.
    # Inputs: "grads["dA" + str(l + 1)], current_cache".
    #Outputs: "grads["dA" + str(l)] , grads["dW" + str(l + 1)] , grads["db" + str(l + 1)] 
    current_cache = caches(l,:);
    [dA_prev_temp, dW_temp, db_temp] = linear_activation_backward(grads.(strcat('dA', mat2str(l))), current_cache, activation = allLayer);
    grads.(strcat('dA', mat2str(l-1))) = dA_prev_temp;
    grads.(strcat('dW', mat2str(l)))= dW_temp;
    grads.(strcat('db', mat2str(l))) = db_temp;
  endfor

endfunction
