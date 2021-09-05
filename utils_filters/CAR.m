
function [data10, data11, data12, data13] = CAR (X, N, labels, show_time) #
  ## FILTRO CAR###############
  #args (Stimulidata, [Nsam,Nchan,Ntrial], label)
  if show_time 
    tic;    disp("")
    disp("Iniciando CAR")
  endif

  data_car = zeros (N (1), N (2));
  count_dez = 1;
  count_onze = 1;
  count_doze = 1;
  count_treze = 1;
  data10 = zeros (N (1), N (2), 12);
  data11 = zeros (N (1), N (2), 12);
  data12 = zeros (N (1), N (2), 12);
  data13 = zeros (N (1), N (2), 12);
  
  for trial = 1:N (3)
    data = X(:,:,trial);
    x_medio = mean (data, 2);
    ## chapando todos em um sï¿½ canal
    for canal = 1:N (2)
      ## todos os canais para um trial
      data_car (:,canal) = data (:,canal) - x_medio;
    endfor
    
    if (labels (trial) == 1)
      data10 (:, :, count_dez++) = data_car;
    elseif (labels (trial) == 2)
      data11 (:, :, count_onze++) = data_car;
    elseif (labels (trial) == 3)
      data12 (:, :, count_doze++) = data_car;
    elseif (labels (trial) == 4)
      data13 (:, :, count_treze++) = data_car;
    endif
   
  endfor
  
  if show_time 
    toc;
    disp("Fim CAR")
    disp("")
  endif
endfunction

