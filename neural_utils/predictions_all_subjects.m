#Predictions_subjects
  #clear 
  #clc 
  
  addpath('C:/Users/Lucas/Documents/Projetos/KazuoIC/OCTAVE/CAR-LS Funcoes/utils_car'); 
  addpath('C:/Users/Lucas/Documents/Projetos/KazuoIC/OCTAVE/CAR-LS Funcoes/neural_utils'); 
  addpath('C:/Users/Lucas/Documents/Projetos/KazuoIC/OCTAVE/CAR-LS Funcoes'); 
  files=glob('C:\Users\Lucas\Documents\Projetos\KazuoIC\OCTAVE\Subjects\*.mat');
  #load ('NN_S123_batch2.mat'); 
  #parameters = Para_HyperPara_Cost.parameters
  
  lastLayer = 'softmax'
  allLayer = 'tanh'
  a = 12
  ACC_per_subject = []
  show_time = false
  quantos_sujeitos = 15
  confmats = {}

  for i=1:quantos_sujeitos
    confmat = zeros(4,4);
    [~, name] = fileparts (files{i});
    eval(sprintf("%s = load('%s');", name, files{i}))
    eval(sprintf("load('%s')", files{i}))
    
    [Nsamples, Nchans, Ntrials]=size(stimuliData);
    N = [Nsamples Nchans Ntrials];
    
    data_test = CAR_ExtFeat_MedChannel (stimuliData, N, label, show_time); 
    data_test = data_test./sqrt(var(data_test,1));
    [f m] = size(data_test');
    
    z = zeros(f,m);
    for j=1:f
      z(j, (a*(j-1)+1):(j*a)) = 1;
    endfor
    Y_test = z;
    
    [Predict, probas] = predict_softmax(data_test', Y_test, parameters, lastLayer, allLayer);
    
    #[~, p] = max (probas(:,:));
    [~,idy] = max(Y_test);
        
    for pp = 1:size(Predict')      
      confmat(idy(pp),Predict(pp)) +=1;
    endfor 
    #acc_conf = sum(dot(eye (4), confmat))/m*100 % jeito mais custoso de calcular acc
    acc = (sum((Predict == idy)/m))*100;
    ACC_per_subject(i,1) = acc;
    confmats.(strcat('confmat',mat2str(i))) = confmat;
  endfor
  
  #save NN_S123_batch_confmats.mat confmats