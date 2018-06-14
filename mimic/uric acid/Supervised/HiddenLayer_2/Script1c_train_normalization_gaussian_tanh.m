%----- 1. variable declaration 
inputSize = 15;
hiddenLayer1Size = 5;
hiddenLayer2Size = 5; 
outputSize = 1;
lambda = 0.000001;         % weight decay parameter       


%----- 2a. load trainingset
inputD = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/train.csv");
%disp(size(inputD)); %-- 569 17

yD = inputD(:,1);
%size(yD) %-- 569 1

%----- 2b. normalize the dataset
inputD = Script2_normalizeData(inputD(:,3:end)); 
%disp(size(inputD)); %-- 569 15


%----- 3. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize);
%disp(size(theta)); %--281 1


%----- 4. calculate cost and gradients
[cost,grad] = Script3_sparseAutoencoder_tanh(theta, inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize, inputD, yD, lambda);


%----- 5. implement gradient checking 
numgrad = Script4_gradientChecking(@(x) Script3_sparseAutoencoder_tanh(x, inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize, inputD, yD, lambda), theta);

disp([numgrad(1:10) grad(1:10)]); 

% Compare numerically computed gradients with the ones obtained from backpropagation
diff = norm(numgrad-grad)/norm(numgrad+grad);
disp(diff); %should be small; these values are usually less than 1e-9
disp(diff < 1e-9); %-- 1 (note: is diff is less than 1e-9, the function value is 1) 
 

%----- 6. implement L-BFGS to train dataset
addpath('/home/pinkpanther/Documents/Studies/Master Thesis/code/octave/minFunc');

theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize);

options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost function. Generally, for minFunc to work, you need a function pointer with two outputs: the function value and the gradient. In our problem, Script3_sparseAutoencoder.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'on';
options.useMex = false;   % when using octave and not MATLAB

[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder_tanh(p, inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--281 1


%----- 7. calculating accuracy of the training set
predict = Script5_predict_tanh(inputD, opttheta, inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize);

fprintf('Train Accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 8. calculating accuracy of the test set
%----- 8a. load testset
inputtest = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/test.csv");
%disp(size(inputtest)); %-- 244 17

ytest = inputtest(:,1);
%size(ytest) %-- 244 1

%----- 8b. normalize the testset
inputtest = Script2_normalizeData(inputtest(:,3:end)); 
%disp(size(inputtest)); %-- 244 15

%----- 8c. calculating accuracy of the test set
predicttest = Script5_predict_tanh(inputtest, opttheta, inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize);

fprintf('Test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 
                                                  
