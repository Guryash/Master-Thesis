%----- 1. variable declaration 
inputSize = 15;
hiddenLayer1Size = 25; 
outputSize = 1;
lambda = 0.0001; % weight decay parameter       


%----- 1a. variable declaration - minFunc
addpath('/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/code/octave/minFunc');

options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost function. Generally, for minFunc to work, you need a function pointer with two outputs: the function value and the gradient. In our problem, Script3_sparseAutoencoder.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'final';
options.useMex = false;   % when using octave and not MATLAB


%----- 2. load data
%----- 2a. load cross validation set 1
inputD1 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/amino transferase/originalData/crossbetter2original1.csv");
%disp(size(inputD1)); %-- 1276 17

yD1 = inputD1(:,1);
%size(yD1) %-- 1276 1

inputD1 = inputD1(:,3:end); 
%disp(size(inputD1)); %-- 1276 15

%----- 2b. load cross validation set 2
inputD2 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/amino transferase/originalData/crossbetter2original2.csv");
%disp(size(inputD2)); %-- 1276 17

yD2 = inputD2(:,1);
%size(yD2) %-- 1276 1

inputD2 = inputD2(:,3:end); 
%disp(size(inputD2)); %-- 1276 15

%----- 2c. load cross validation set 3
inputD3 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/amino transferase/originalData/crossbetter2original3.csv");
%disp(size(inputD3)); %-- 1276 17

yD3 = inputD3(:,1);
%size(yD3) %-- 1276 1

inputD3 = inputD3(:,3:end); 
%disp(size(inputD3)); %-- 1276 15

%----- 2d. load cross validation set 4
inputD4 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/amino transferase/originalData/crossbetter2original4.csv");
%disp(size(inputD4)); %-- 1276 17

yD4 = inputD4(:,1);
%size(yD4) %-- 1276 1

inputD4 = inputD4(:,3:end); 
%disp(size(inputD4)); %-- 1276 15



%---------------------------------------------------------------------------------------------------------
disp("Iteration 1");
%----- 3a. combining to sets
inputD = [inputD1; inputD2; inputD3];
%disp(size(inputD)); %-- 3828 17

yD = [yD1; yD2; yD3];
%disp(size(yD)); %-- 3828 1

%----- 4. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1


%----- 5. calculate cost and gradients
[cost,grad] = Script3_sparseAutoencoder(theta, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda);


%----- 6. implement gradient checking 
numgrad = Script4_gradientChecking(@(x) Script3_sparseAutoencoder(x, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta);

disp([numgrad(1:10) grad(1:10)]); 

% Compare numerically computed gradients with the ones obtained from backpropagation
diff = norm(numgrad-grad)/norm(numgrad+grad);
disp(diff); %should be small; these values are usually less than 1e-9
disp(diff < 1e-9); %-- 0; the difference is around 1e-7 (note: is diff is less than 1e-9, the function value is 1) 
 

%----- 7. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 8. calculating accuracy of the training set
predict = Script5_predict(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 1 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 9. calculating accuracy of the test set
%----- 9a. load testset
inputtest = inputD4;
%disp(size(inputtest)); %-- 1276 15

ytest = yD4;
%size(ytest) %-- 1276 1


%----- 9b. calculating accuracy of the test set
predicttest = Script5_predict(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 1 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 



disp("Iteration 2");
%----- 3. combining to sets
inputD = [inputD2; inputD3; inputD4];
%disp(size(inputD)); %-- 3828 15

yD = [yD2; yD3; yD4];
%disp(size(yD)); %-- 3828 1

%----- 4. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 5. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 6. calculating accuracy of the training set
predict = Script5_predict(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 2 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 7. calculating accuracy of the test set
%----- 7a. load testset
inputtest = inputD1;
%disp(size(inputtest)); %-- 1276 15

ytest = yD1;
%size(ytest) %-- 1276 1

%----- 7b. calculating accuracy of the test set
predicttest = Script5_predict(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 2 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 



disp("Iteration 3");
%----- 3. combining to sets
inputD = [inputD3; inputD4; inputD1];
%disp(size(inputD)); %-- 3828 15

yD = [yD3; yD4; yD1];
%disp(size(yD)); %-- 3828 1

%----- 4. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 5. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 6. calculating accuracy of the training set
predict = Script5_predict(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 3 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 7. calculating accuracy of the test set
%----- 7a. load testset
inputtest = inputD2;
%disp(size(inputtest)); %-- 1276 15

ytest = yD2;
%size(ytest) %-- 1276 1

%----- 7b. calculating accuracy of the test set
predicttest = Script5_predict(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 3 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 



disp("Iteration 4");
%----- 3. combining to sets
inputD = [inputD4; inputD1; inputD2];
%disp(size(inputD)); %-- 3828 15

yD = [yD4; yD1; yD2];
%disp(size(yD)); %-- 3828 1

%----- 4. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 5. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 6. calculating accuracy of the training set
predict = Script5_predict(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 4 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 7. calculating accuracy of the test set
%----- 7a. load testset
inputtest = inputD3;
%disp(size(inputtest)); %-- 1276 15

ytest = yD3;
%size(ytest) %-- 1276 1

%----- 7b. calculating accuracy of the test set
predicttest = Script5_predict(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 4 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 



                                                  
