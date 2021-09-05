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
## @deftypefn {} {@var{retval} =} cost (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-03

function cost = compute_cost(AL, Y, error_type)

    #{
    Implement the cost function defined by equation (7).

    Arguments:
    AL -- probability vector corresponding to your label predictions, shape (1, number of examples)
    Y -- true "label" vector (for example: containing 0 if non-cat, 1 if cat), shape (1, number of examples)

    Returns:
    cost -- cross-entropy cost
    #}
    
    H = size(Y)(1);
    size(AL); # Numero de classes
    m = size(Y)(2); # Numero de exemplos
    
    if strcmp(error_type, 'Log')
      # Compute loss from aL and y.  
      m = size(Y)(2); 
      a = sum(Y.*log(AL)+(1-Y).*log(1-AL),2);
      cost = -(1/m)*a;
      
    elseif strcmp(error_type, 'CrossEntropy')
      a = Y.*log(AL);
      b = sum(a,1);
      c = sum(b,2);          
      cost = -(1/m)*c;
    endif 
    
    cost = squeeze(cost);     # To make sure your cost's shape is what we expect (e.g. this turns [[17]] into 17).

endfunction
