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
## @deftypefn {} {@var{retval} =} predict (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-04

function p = predict(X, Y, parameters)
    #{
    This function is used to predict the results of a  L-layer neural network.
    
    Arguments:
    X -- data set of examples you would like to label
    parameters -- parameters of the trained model
    
    Returns:
    p -- predictions for the given dataset X
    #}
    
    m = size(X)(2);
    n = floor(numfields(parameters)/2); # number of layers in the neural network
    p = zeros(1,m);
    
    # Forward propagation
    [probas, caches] = L_model_forward(X, parameters);

    # convert probas to 0/1 predictions
    for i = 1:size(probas)(2)
        if probas(1,i) > 0.5
            p(1,i) = 1;
        else
            p(1,i)= 0;
        endif 
   endfor
   
    #print results
    #print ("predictions: " + str(p))
    #print ("true labels: " + str(y))
    printf("Accuracy: %f%% \n ", (sum((p == Y)/m))*100)
    probas    
endfunction
