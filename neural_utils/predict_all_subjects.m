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
## @deftypefn {} {@var{retval} =} predict_all_subjects (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Lucas <Lucas@DESKTOP-TFSD5P7>
## Created: 2020-09-10

function [ACC_per_subject, confmats] = predict_all_subjects (parameters)
  files=glob('C:\Users\Lucas\Documents\Projetos\KazuoIC\OCTAVE\Subjects\*.mat');
  lastLayer = 'softmax'
  allLayer = 'tanh'
  a = 12
  ACC_per_subject = []
  show_time = false
  quantos_sujeitos = 15
  confmats = {}
  ela = 0
  for i=1:quantos_sujeitos
    
    confmat = zeros(4,4);
    [~, name] = fileparts (files{i});
    eval(sprintf("%s = load('%s');", name, files{i}))
    eval(sprintf("load('%s')", files{i}))
    
    [Nsamples, Nchans, Ntrials]=size(stimuliData);
    N = [Nsamples Nchans Ntrials];
    
    data_test = CAR_ExtFeat_MedChannel (stimuliData, N, label, show_time); 
    data_test = (data_test-mean(data_test,1))./sqrt(var(data_test,1));

##    [tri10,tri11,tri12,tri13] = MDA (data_test);
##    data_test=[tri10,tri11,tri12,tri13];
##    
    [f m] = size(data_test');
    z = zeros(f+1,m);
    for j=1:f
      z(j, (a*(j-1)+1):(j*a)) = 1;
    endfor
    Y_test = z;
    tic;
    [Predict, probas] = predict_softmax(data_test', Y_test, parameters, lastLayer, allLayer);
    ela += toc;   

    #[~, p] = max (probas(:,:));
    [~,idy] = max(Y_test);
    for pp = 1:size(Predict')      
      confmat(idy(pp),Predict(pp)) +=1;
    endfor 
    #acc_conf = sum(dot(eye (4), confmat))/m*100 % jeito mais custoso de calcular acc
    acc = (sum((Predict == idy)/m))*100;
    ACC_per_subject(i,1) = acc;
    confmats.(strcat('confmat_S',mat2str(i))) = confmat;
  endfor
  mean_acc = mean(ACC_per_subject)
  ela =  ela/15
endfunction
