%----- 1. variable declaration 
inputSize = 15;
hiddenLayer1Size = 5; 
outputSize = 1;
lambda = 0.000001; % weight decay parameter       


disp("Iteration 1");
%----- 2a. load cross validation set 1
inputD1 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear1.csv");
%disp(size(inputD1)); %-- 2588 17

yD1 = inputD1(:,1);
%size(yD1) %-- 2588 1

inputD1 = inputD1(:,3:end); 
%disp(size(inputD1)); %-- 2588 15

%----- 2b. load cross validation set 2
inputD2 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear2.csv");
%disp(size(inputD2)); %-- 2588 17

yD2 = inputD2(:,1);
%size(yD2) %-- 2588 1

inputD2 = inputD2(:,3:end); 
%disp(size(inputD2)); %-- 2588 15

%----- 2c. load cross validation set 3
inputD3 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear3.csv");
%disp(size(inputD3)); %-- 2588 17

yD3 = inputD3(:,1);
%size(yD3) %-- 2588 1

inputD3 = inputD3(:,3:end); 
%disp(size(inputD3)); %-- 2588 15

%----- 2d. combining to sets
inputD = [inputD1; inputD2; inputD3];
%disp(size(inputD)); %-- 7764 17

yD = [yD1; yD2; yD3];
%disp(size(yD)); %-- 7764 1

%----- 3. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1


%----- 4. calculate cost and gradients
[cost,grad] = Script3_sparseAutoencoder(theta, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda);


%----- 5. implement gradient checking 
numgrad = Script4_gradientChecking(@(x) Script3_sparseAutoencoder(x, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta);

disp([numgrad(1:10) grad(1:10)]); 

% Compare numerically computed gradients with the ones obtained from backpropagation
diff = norm(numgrad-grad)/norm(numgrad+grad);
disp(diff); %should be small; these values are usually less than 1e-9
disp(diff < 1e-9); %-- 0; the difference is around 1e-7 (note: is diff is less than 1e-9, the function value is 1) 
 

%----- 6. implement L-BFGS to train dataset
addpath('/home/pinkpanther/Documents/Studies/Master Thesis/code/octave/minFunc');

options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost function. Generally, for minFunc to work, you need a function pointer with two outputs: the function value and the gradient. In our problem, Script3_sparseAutoencoder.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'on';
options.useMex = false;   % when using octave and not MATLAB

[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 7. calculating accuracy of the training set
predict = Script5_predict(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 1 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 8. calculating accuracy of the test set
%----- 8a. load testset
inputtest = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear4.csv");
%disp(size(inputtest)); %-- 2588 17

ytest = inputtest(:,1);
%size(ytest) %-- 2588 1

inputtest = inputtest(:,3:end); 
%disp(size(inputtest)); %-- 2588 15

%----- 8b. calculating accuracy of the test set
predicttest = Script5_predict(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 1 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 

pause;
disp("Iteration 2");
%----- 2a. load cross validation set 1
inputD1 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear2.csv");
%disp(size(inputD1)); %-- 2588 17

yD1 = inputD1(:,1);
%size(yD1) %-- 2588 1

inputD1 = inputD1(:,3:end); 
%disp(size(inputD1)); %-- 2588 15

%----- 2b. load cross validation set 2
inputD2 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear3.csv");
%disp(size(inputD2)); %-- 2588 17

yD2 = inputD2(:,1);
%size(yD2) %-- 2588 1

inputD2 = inputD2(:,3:end); 
%disp(size(inputD2)); %-- 2588 15

%----- 2c. load cross validation set 3
inputD3 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear4.csv");
%disp(size(inputD3)); %-- 2588 17

yD3 = inputD3(:,1);
%size(yD3) %-- 2588 1

inputD3 = inputD3(:,3:end); 
%disp(size(inputD3)); %-- 2588 15

%----- 2d. combining to sets
inputD = [inputD1; inputD2; inputD3];
%disp(size(inputD)); %-- 7764 17

yD = [yD1; yD2; yD3];
%disp(size(yD)); %-- 7764 1

%----- 3. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 4. implement L-BFGS to train dataset
addpath('/home/pinkpanther/Documents/Studies/Master Thesis/code/octave/minFunc');

options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost function. Generally, for minFunc to work, you need a function pointer with two outputs: the function value and the gradient. In our problem, Script3_sparseAutoencoder.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'on';
options.useMex = false;   % when using octave and not MATLAB

[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 5. calculating accuracy of the training set
predict = Script5_predict(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 2 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 6. calculating accuracy of the test set
%----- 6a. load testset
inputtest = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear1.csv");
%disp(size(inputtest)); %-- 2588 17

ytest = inputtest(:,1);
%size(ytest) %-- 2588 1

inputtest = inputtest(:,3:end); 
%disp(size(inputtest)); %-- 2588 15

%----- 6b. calculating accuracy of the test set
predicttest = Script5_predict(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 2 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 

pause;
disp("Iteration 3");
%----- 2a. load cross validation set 1
inputD1 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear3.csv");
%disp(size(inputD1)); %-- 2588 17

yD1 = inputD1(:,1);
%size(yD1) %-- 2588 1

inputD1 = inputD1(:,3:end); 
%disp(size(inputD1)); %-- 2588 15

%----- 2b. load cross validation set 2
inputD2 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear4.csv");
%disp(size(inputD2)); %-- 2588 17

yD2 = inputD2(:,1);
%size(yD2) %-- 2588 1

inputD2 = inputD2(:,3:end); 
%disp(size(inputD2)); %-- 2588 15

%----- 2c. load cross validation set 3
inputD3 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear1.csv");
%disp(size(inputD3)); %-- 2588 17

yD3 = inputD3(:,1);
%size(yD3) %-- 2588 1

inputD3 = inputD3(:,3:end); 
%disp(size(inputD3)); %-- 2588 15

%----- 2d. combining to sets
inputD = [inputD1; inputD2; inputD3];
%disp(size(inputD)); %-- 7764 17

yD = [yD1; yD2; yD3];
%disp(size(yD)); %-- 7764 1


%----- 3. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 4. implement L-BFGS to train dataset
addpath('/home/pinkpanther/Documents/Studies/Master Thesis/code/octave/minFunc');

options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost function. Generally, for minFunc to work, you need a function pointer with two outputs: the function value and the gradient. In our problem, Script3_sparseAutoencoder.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'on';
options.useMex = false;   % when using octave and not MATLAB

[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 5. calculating accuracy of the training set
predict = Script5_predict(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 3 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 6. calculating accuracy of the test set
%----- 6a. load testset
inputtest = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear2.csv");
%disp(size(inputtest)); %-- 2588 17

ytest = inputtest(:,1);
%size(ytest) %-- 2588 1

inputtest = inputtest(:,3:end); 
%disp(size(inputtest)); %-- 2588 15

%----- 6b. calculating accuracy of the test set
predicttest = Script5_predict(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 3 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 

pause;
disp("Iteration 4");
%----- 2a. load cross validation set 1
inputD1 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear4.csv");
%disp(size(inputD1)); %-- 2588 17

yD1 = inputD1(:,1);
%size(yD1) %-- 2588 1

inputD1 = inputD1(:,3:end); 
%disp(size(inputD1)); %-- 2588 15

%----- 2b. load cross validation set 2
inputD2 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear1.csv");
%disp(size(inputD2)); %-- 2588 17

yD2 = inputD2(:,1);
%size(yD2) %-- 2588 1

inputD2 = inputD2(:,3:end); 
%disp(size(inputD2)); %-- 2588 15

%----- 2c. load cross validation set 3
inputD3 = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear2.csv");
%disp(size(inputD3)); %-- 2588 17

yD3 = inputD3(:,1);
%size(yD3) %-- 2588 1

inputD3 = inputD3(:,3:end); 
%disp(size(inputD3)); %-- 2588 15

%----- 2d. combining to sets
inputD = [inputD1; inputD2; inputD3];
%disp(size(inputD)); %-- 7764 17

yD = [yD1; yD2; yD3];
%disp(size(yD)); %-- 7764 1


%----- 3. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 4. implement L-BFGS to train dataset
addpath('/home/pinkpanther/Documents/Studies/Master Thesis/code/octave/minFunc');

options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost function. Generally, for minFunc to work, you need a function pointer with two outputs: the function value and the gradient. In our problem, Script3_sparseAutoencoder.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'on';
options.useMex = false;   % when using octave and not MATLAB

[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 5. calculating accuracy of the training set
predict = Script5_predict(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 4 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 6. calculating accuracy of the test set
%----- 6a. load testset
inputtest = csvread("/home/pinkpanther/Documents/Studies/Master Thesis/Data/octave/mimic/amino transferase/linearData/crosslinear3.csv");
%disp(size(inputtest)); %-- 2588 17

ytest = inputtest(:,1);
%size(ytest) %-- 2588 1

inputtest = inputtest(:,3:end); 
%disp(size(inputtest)); %-- 2588 15

%----- 6b. calculating accuracy of the test set
predicttest = Script5_predict(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 4 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 

pause;


                                                  
