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
## @deftypefn {} {@var{retval} =} update_parameters (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-04

function parameters = update_parameters (parameters, grads, learning_rate)
    #{
    Update parameters using gradient descent
    
    Arguments:
    parameters -- python dictionary containing your parameters 
    grads -- python dictionary containing your gradients, output of L_model_backward
    
    Returns:
    parameters -- python dictionary containing your updated parameters 
                  parameters["W" + str(l)] = ... 
                  parameters["b" + str(l)] = ...
    #}
    
    L = floor(numfields(parameters)/2);  # number of layers in the neural network

    # Update rule for each parameter. Use a for loop.
    for l=0:L-1
        parameters.(strcat("W", mat2str(l+1))) -= learning_rate*grads.(strcat("dW", mat2str(l+1)));
        parameters.(strcat("b", mat2str(l+1))) -= learning_rate*grads.(strcat("db", mat2str(l+1)));
    endfor
endfunction
