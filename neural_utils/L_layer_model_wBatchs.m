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
## @deftypefn {} {@var{retval} =} L_layer_model_wBatchs (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-09

function [parameters, costs] = L_layer_model_wBatchs (X, Y, init_parameters, layers_dims, lastLayer, allLayer, Nbatch, learning_rate, num_iterations ,error_type, print_cost, currentSubject, initialization)
  #(X, Y, init_parameter, dim, lastLayer, allLayer, Nbatch, learning_rate, num_iterations, error_type, print_cost = true);
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
  printf('\n')
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
    parameters = initialize_parameters(layers_dims, initialization);
  else
    parameters = init_parameters;
  endif
  
  NsampBatch = size(X)(2)/Nbatch
  
  # Loop (gradient descent)
  for i = 0:num_iterations
    for j =1:Nbatch
      X_batch = X(:,NsampBatch*(j-1)+1 :(j*NsampBatch));
      Y_batch = Y(:,NsampBatch*(j-1)+1 :(j*NsampBatch));
      # Forward propagation: [LINEAR -> RELU]*(L-1) -> LINEAR -> SIGMOID.
      [AL, caches] = L_model_forward(X_batch, parameters, lastLayer, allLayer);
      
      # Compute cost.
      cost = compute_cost(AL, Y_batch, 'CrossEntropy');

      # Backward propagation.
      grads = L_model_backward(AL, Y_batch, caches, lastLayer, allLayer, error_type);
      #Mudar o AL e o DZ no Model back
      # Update parameters.
      parameters =  update_parameters(parameters, grads, learning_rate);
    endfor  
    # Print the cost every 100 training example
    if print_cost && rem (i, 100) == 0
      printf ("Cost after iteration %i: %f \n" , i, cost);
      costs = cat(2, costs,cost);
      if rem (i, 2000) == 0
        name_file = strcat('lastsave_batch', currentSubject,'__',num2str(i) ,'steeps.mat')
        name_file2 = strcat('costs_batch', currentSubject,'__',num2str(i) ,'steeps.mat')
        save(name_file,'parameters')
        save(name_file2,'costs')
        plot(costs)
      endif
    endif
   
  endfor     
  xlabel ("iteration (per 100)");
  ylabel ("Cost");
  title (sprintf("Custo x Iterations; Batchsize = %i; ", Nbatch));
  #title (sprintf("Custo x Iterations; Batchsize = %i; Trainingw/: %s ", Nbatch, currentSubject));
  #legend ({"Primeira Partição", "Segunda Partição", "Terceira Partição", "Quarta Partição Partição", "Quinta Partição"})
  hold on;
endfunction
