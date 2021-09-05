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
## @deftypefn {} {@var{retval} =} linear_activation_backward (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-03

function [dA_prev, dW, db] = linear_activation_backward(dA, cache, activation, Y)
  #{
  """
    Implement the backward propagation for the LINEAR->ACTIVATION layer.
    
    Arguments:
    dA -- post-activation gradient for current layer l 
    cache -- a cell of values (linear_cache, activation_cache) we store for computing backward propagation efficiently
    activation -- the activation to be used in this layer, stored as a text string: "sigmoid" or "relu"
    
    Returns:
    dA_prev -- Gradient of the cost with respect to the activation (of the previous layer l-1), same shape as A_prev
    dW -- Gradient of the cost with respect to W (current layer l), same shape as W
    db -- Gradient of the cost with respect to b (current layer l), same shape as b
    #}

    [linear_cache, activation_cache] = cache{:};
   
    if strcmp(activation, "lrelu")
      dZ =  lrelu_backward(dA, activation_cache); #activition cache == z^[l]
      [dA_prev, dW, db] = linear_backward(dZ, linear_cache);
        
    elseif strcmp(activation, "sigmoid")
      dZ = sigmoid_backward(dA, activation_cache); #activition cache == z^[l]
      [dA_prev, dW, db] = linear_backward(dZ, linear_cache);
        
    elseif strcmp(activation, "tanh")
      dZ = tanh_backward(dA, activation_cache); #activition cache == z^[l]
      [dA_prev, dW, db] = linear_backward(dZ, linear_cache);
      
    elseif strcmp(activation, "softmax")
      dZ = softmax_backward(dA, activation_cache, Y); #activition cache == z^[l]
      [dA_prev, dW, db] = linear_backward(dZ, linear_cache);  
    endif
      
endfunction
