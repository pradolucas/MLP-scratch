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
## @deftypefn {} {@var{retval} =} _layer_model (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-04

function parameters = L_layer_model (X, Y, layers_dims, lastLayer, allLayer, learning_rate, num_iterations , print_cost, error_type, init_parameters)
    #{
    Implements a L-layer neural network: [LINEAR->RELU]*(L-1)->LINEAR->SIGMOID.
    
    Arguments:
    X -- data, numpy array of shape (num_px * num_px * 3, number of examples)
    Y -- true "label" vector (containing 0 if cat, 1 if non-cat), of shape (1, number of examples)
    layers_dims -- list containing the input size and each layer size, of length (number of layers + 1).
    learning_rate -- learning rate of the gradient descent update rule
    num_iterations -- number of iterations of the optimization loop
    print_cost -- if True, it prints the cost every 100 steps
    
    Returns:
    parameters -- parameters learnt by the model. They can then be used to predict.
    #}
    if nargin <8
      print_cost = false
    elseif nargin <7
      num_iterations = 1000
    elseif nargin <6
      learning_rate = 0.0075
    endif
    costs = [];                         # keep track of cost
    
    # Parameters initialization.
    if  isequal(init_parameters,{})
      parameters = initialize_parameters(layers_dims);
    else
      parameters = init_parameters
    endif


    # Loop (gradient descent)
    for i = 0:num_iterations
     
        # Forward propagation: [LINEAR -> RELU]*(L-1) -> LINEAR -> SIGMOID.
        [AL, caches] = L_model_forward(X, parameters, lastLayer, allLayer);
        
        # Compute cost.
        cost = compute_cost(AL, Y, 'CrossEntropy');
    
        # Backward propagation.
        grads = L_model_backward(AL, Y, caches, lastLayer, allLayer, error_type);
        #Mudar o AL e o DZ no Model back
        # Update parameters.
        parameters =  update_parameters(parameters, grads, learning_rate);

        
        # Print the cost every 100 training example
        if print_cost && rem (i, 100) == 0
          printf ("Cost after iteration %i: %f \n" , i, cost);
          costs = cat(2, costs,cost);
        endif
        
    endfor     
    plot(costs)
    xlabel ("iteration (per 100)");
    ylabel ("Cost");
endfunction
