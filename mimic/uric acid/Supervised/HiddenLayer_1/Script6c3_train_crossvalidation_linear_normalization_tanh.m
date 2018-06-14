%----- 1. variable declaration 
inputSize = 15;
hiddenLayer1Size = 5; 
outputSize = 1;
lambda = 0.00001; % weight decay parameter       

%----- 1a. variable declaration - minFunc
addpath('/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/code/octave/minFunc');

options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost function. Generally, for minFunc to work, you need a function pointer with two outputs: the function value and the gradient. In our problem, Script3_sparseAutoencoder.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'final';
options.useMex = false;   % when using octave and not MATLAB


%----- 2. load data
%----- 2a. load cross validation set 1
inputD1 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/linearData/crosslinear1.csv");
%disp(size(inputD1)); %-- 271 17

yD1 = inputD1(:,1);
%size(yD1) %-- 271 1

inputD1 = inputD1(:,3:end); 
%disp(size(inputD1)); %-- 271 15

%----- 2b. load cross validation set 2
inputD2 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/linearData/crosslinear2.csv");
%disp(size(inputD2)); %-- 271 17

yD2 = inputD2(:,1);
%size(yD2) %-- 271 1

inputD2 = inputD2(:,3:end); 
%disp(size(inputD1)); %-- 271 15 

%----- 2c. load testset
inputD3 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/linearData/crosslinear3.csv");
%disp(size(inputD3)); %-- 271 17

yD3 = inputD3(:,1);
%size(yD3) %-- 271 1

inputD3 = inputD3(:,3:end); 
%disp(size(inputD3)); %-- 271 15



%---------------------------------------------------------------------------------------------------------
t=cputime; %-- processing time

disp("Iteration 1");
%----- 3a. combining to sets as input
inputD = [inputD1; inputD2];
%disp(size(inputD)); %-- 542 15

yD = [yD1; yD2];
%disp(size(yD)); %-- 542 1

%----- 3b. normalize the dataset
inputD = Script2_normalizeData(inputD); 
%disp(size(inputD)); %-- 542 15


%----- 4. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1


%----- 5. calculate cost and gradients
[cost,grad] = Script3_sparseAutoencoder_tanh(theta, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda);


%----- 6. implement gradient checking 
numgrad = Script4_gradientChecking(@(x) Script3_sparseAutoencoder_tanh(x, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta);

disp([numgrad(1:10) grad(1:10)]); 

% Compare numerically computed gradients with the ones obtained from backpropagation
diff = norm(numgrad-grad)/norm(numgrad+grad);
disp(diff); %should be small; these values are usually less than 1e-9
disp(diff < 1e-9); %-- 0; the difference is around 1e-7 (note: is diff is less than 1e-9, the function value is 1) 
 

%----- 7. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder_tanh(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 8. calculating accuracy of the training set
predict = Script5_predict_tanh(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 1 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 9. calculating accuracy of the test set
%----- 9a. load testset
inputtest = inputD3;
%disp(size(inputtest)); %-- 271 15

ytest = yD3;
%size(ytest) %-- 271 1

%----- 9b. normalize the dataset
inputtest = Script2_normalizeData(inputtest); 
%disp(size(inputtest)); %-- 271 15

%----- 9c. calculating accuracy of the test set
predicttest = Script5_predict_tanh(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 1 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 


%----- 10. performance metrics
%----- 10a. calculating for training set
tptrain = 0;
tntrain = 0;
fptrain = 0;
fntrain = 0;

mtrain = size(yD, 1);
for i=1:mtrain
    if predict(i) == yD(i) && yD(i) == 1
	tptrain = tptrain + 1;
    end

    if predict(i) == yD(i) && yD(i) == 0
	tntrain = tntrain + 1;
    end

    if predict(i) != yD(i) && yD(i) == 0
	fptrain = fptrain + 1;
    end

    if predict(i) != yD(i) && yD(i) == 1
	fntrain = fntrain + 1;
    end
end


%printf('true positives of training set for Iteration 1: %f\n', tptrain);
%printf('true negatives of training set for Iteration 1: %f\n', tntrain);
%printf('false positives of training set for Iteration 1: %f\n', fptrain);
%printf('false negatives of training set for Iteration 1: %f\n', fntrain);

%----- 10b. calculating for testing set
tptest = 0;
tntest = 0;
fptest = 0;
fntest = 0;

mtest = size(ytest, 1);
for i=1:mtest
    if predicttest(i) == ytest(i) && ytest(i) == 1
	tptest = tptest + 1;
    end

    if predicttest(i) == ytest(i) && ytest(i) == 0
	tntest = tntest + 1;
    end

    if predicttest(i) != ytest(i) && ytest(i) == 0
	fptest = fptest + 1;
    end

    if predicttest(i) != ytest(i) && ytest(i) == 1
	fntest = fntest + 1;
    end
end


%printf('true positives of testing set for Iteration 1: %f\n', tptest);
%printf('true negatives of testing set for Iteration 1: %f\n', tntest);
%printf('false positives of testing set for Iteration 1: %f\n', fptest);
%printf('false negatives of testing set for Iteration 1: %f\n', fntest);

printf('total true positives Iteration 1: %f\n', tptrain + tptest);
printf('total true negatives Iteration 1: %f\n', tntrain + tntest);
printf('total false positives Iteration 1: %f\n', fptrain + fptest);
printf('total false negatives Iteration 1: %f\n', fntrain + fntest);




%---------------------------------------------------------------------------------------------------------
disp("Iteration 2");
%----- 3a. combining to sets as input
inputD = [inputD2; inputD3];
%disp(size(inputD)); %-- 542 15

yD = [yD2; yD3];
%disp(size(yD)); %-- 542 1

%----- 3b. normalize the dataset
inputD = Script2_normalizeData(inputD); 
%disp(size(inputD)); %-- 542 15

%----- 4. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 7. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder_tanh(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 8. calculating accuracy of the training set
predict = Script5_predict_tanh(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 2 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 9. calculating accuracy of the test set
%----- 9a. load testset
inputtest = inputD1;
%disp(size(inputtest)); %-- 271 15

ytest = yD1;
%size(ytest) %-- 271 1

%----- 9b. normalize the dataset
inputtest = Script2_normalizeData(inputtest); 
%disp(size(inputtest)); %-- 271 15

%----- 9c. calculating accuracy of the test set
predicttest = Script5_predict_tanh(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 2 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 



%---------------------------------------------------------------------------------------------------------
disp("Iteration 3");
%----- 3a. combining to sets as input
inputD = [inputD1; inputD3];
%disp(size(inputD)); %-- 542 15

yD = [yD1; yD3];
%disp(size(yD)); %-- 542 1

%----- 3b. normalize the dataset
inputD = Script2_normalizeData(inputD); 
%disp(size(inputD)); %-- 542 15

%----- 4. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 7. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder_tanh(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 8. calculating accuracy of the training set
predict = Script5_predict_tanh(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 3 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 9. calculating accuracy of the test set
%----- 9a. load testset
inputtest = inputD2;
%disp(size(inputtest)); %-- 271 15

ytest = yD2;
%size(ytest) %-- 271 1

%----- 9b. normalize the dataset
inputtest = Script2_normalizeData(inputtest); 
%disp(size(inputtest)); %-- 271 15

%----- 9c. calculating accuracy of the test set
predicttest = Script5_predict_tanh(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 3 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 
 
printf('Total cpu time: %f seconds\n', cputime-t); %-- total time


                                                  
