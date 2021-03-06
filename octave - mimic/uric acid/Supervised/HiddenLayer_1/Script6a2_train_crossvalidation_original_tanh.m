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



%---------------------------------------------------------------------------------------------------------
t=cputime; %-- processing time

disp("Iteration 1");
%----- 2a. load cross validation set 1
inputD1 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/originalData/crossoriginal1.csv");
%disp(size(inputD1)); %-- 271 17

yD1 = inputD1(:,1);
%size(yD1) %-- 271 1

inputD1 = inputD1(:,3:end); 
%disp(size(inputD1)); %-- 271 15

%----- 2b. load cross validation set 2
inputD2 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/originalData/crossoriginal2.csv");
%disp(size(inputD2)); %-- 271 17

yD2 = inputD2(:,1);
%size(yD2) %-- 271 1

inputD2 = inputD2(:,3:end); 
%disp(size(inputD1)); %-- 271 15

%----- 2c. combining to sets
inputD = [inputD1; inputD2];
%disp(size(inputD)); %-- 542 17

yD = [yD1; yD2];
%disp(size(yD)); %-- 542 1


%----- 3. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1


%----- 4. calculate cost and gradients
[cost,grad] = Script3_sparseAutoencoder_tanh(theta, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda);


%----- 5. implement gradient checking 
numgrad = Script4_gradientChecking(@(x) Script3_sparseAutoencoder_tanh(x, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta);

disp([numgrad(1:10) grad(1:10)]); 

% Compare numerically computed gradients with the ones obtained from backpropagation
diff = norm(numgrad-grad)/norm(numgrad+grad);
disp(diff); %should be small; these values are usually less than 1e-9
disp(diff < 1e-9); %-- 0; the difference is around 1e-7 (note: is diff is less than 1e-9, the function value is 1) 
 

%----- 6. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder_tanh(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 7. calculating accuracy of the training set
predict = Script5_predict_tanh(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 1 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 8. calculating accuracy of the test set
%----- 8a. load testset
inputtest = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/originalData/crossoriginal3.csv");
%disp(size(inputtest)); %-- 271 17

ytest = inputtest(:,1);
%size(ytest) %-- 271 1

inputtest = inputtest(:,3:end); 
%disp(size(inputtest)); %-- 271 15

%----- 8b. calculating accuracy of the test set
predicttest = Script5_predict_tanh(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 1 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 



%---------------------------------------------------------------------------------------------------------
disp("Iteration 2");
%----- 2a. load cross validation set 1
inputD1 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/originalData/crossoriginal2.csv");
%disp(size(inputD1)); %-- 271 17

yD1 = inputD1(:,1);
%size(yD1) %-- 271 1

inputD1 = inputD1(:,3:end); 
%disp(size(inputD1)); %-- 271 15

%----- 2b. load cross validation set 2
inputD2 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/originalData/crossoriginal3.csv");
%disp(size(inputD2)); %-- 271 17

yD2 = inputD2(:,1);
%size(yD2) %-- 271 1

inputD2 = inputD2(:,3:end); 
%disp(size(inputD1)); %-- 271 15

%----- 2c. combining to sets
inputD = [inputD1; inputD2];
%disp(size(inputD)); %-- 542 17

yD = [yD1; yD2];
%disp(size(yD)); %-- 542 1

%----- 3. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 6. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder_tanh(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 7. calculating accuracy of the training set
predict = Script5_predict_tanh(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 2 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 8. calculating accuracy of the test set
%----- 8a. load testset
inputtest = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/originalData/crossoriginal1.csv");
%disp(size(inputtest)); %-- 271 17

ytest = inputtest(:,1);
%size(ytest) %-- 271 1

inputtest = inputtest(:,3:end); 
%disp(size(inputtest)); %-- 271 15

%----- 8b. calculating accuracy of the test set
predicttest = Script5_predict_tanh(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 2 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 



%---------------------------------------------------------------------------------------------------------
disp("Iteration 3");
%----- 2a. load cross validation set 1
inputD1 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/originalData/crossoriginal3.csv");
%disp(size(inputD1)); %-- 271 17

yD1 = inputD1(:,1);
%size(yD1) %-- 271 1

inputD1 = inputD1(:,3:end); 
%disp(size(inputD1)); %-- 271 15

%----- 2b. load cross validation set 2
inputD2 = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/originalData/crossoriginal1.csv");
%disp(size(inputD2)); %-- 271 17

yD2 = inputD2(:,1);
%size(yD2) %-- 271 1

inputD2 = inputD2(:,3:end); 
%disp(size(inputD1)); %-- 271 15

%----- 2c. combining to sets
inputD = [inputD1; inputD2];
%disp(size(inputD)); %-- 542 17

yD = [yD1; yD2];
%disp(size(yD)); %-- 542 1

%----- 3. generate random parameters, theta
theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize);
%disp(size(theta)); %--171 1
 

%----- 6. implement L-BFGS to train dataset
[opttheta, cost] = minFunc( @(p) Script3_sparseAutoencoder_tanh(p, inputSize, hiddenLayer1Size, outputSize, inputD, yD, lambda), theta, options);

%size(opttheta) %--171 1


%----- 7. calculating accuracy of the training set
predict = Script5_predict_tanh(inputD, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 3 train accuracy: %f\n', mean(double(predict == yD)) * 100); 


%----- 8. calculating accuracy of the test set
%----- 8a. load testset
inputtest = csvread("/home/pinkpanther/Documents/Studies/Semester 6 & 7 - Master Thesis/Data/octave/mimic/uric acid/originalData/crossoriginal2.csv");
%disp(size(inputtest)); %-- 271 17

ytest = inputtest(:,1);
%size(ytest) %-- 271 1

inputtest = inputtest(:,3:end); 
%disp(size(inputtest)); %-- 271 15

%----- 8b. calculating accuracy of the test set
predicttest = Script5_predict_tanh(inputtest, opttheta, inputSize, hiddenLayer1Size, outputSize);

fprintf('cross validation Iteration 3 test Accuracy: %f\n', mean(double(predicttest == ytest)) * 100); 
 
printf('Total cpu time: %f seconds\n', cputime-t); %-- total time

%----- 9. performance metrics
%----- 9a. calculating for training set
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


%printf('true positives of training set for Iteration 3: %f\n', tptrain);
%printf('true negatives of training set for Iteration 3: %f\n', tntrain);
%printf('false positives of training set for Iteration 3: %f\n', fptrain);
%printf('false negatives of training set for Iteration 3: %f\n', fntrain);

%----- 9b. calculating for testing set
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


%printf('true positives of testing set for Iteration 3: %f\n', tptest);
%printf('true negatives of testing set for Iteration 3: %f\n', tntest);
%printf('false positives of testing set for Iteration 3: %f\n', fptest);
%printf('false negatives of testing set for Iteration 3: %f\n', fntest);

printf('total true positives Iteration 3: %f\n', tptrain + tptest);
printf('total true negatives Iteration 3: %f\n', tntrain + tntest);
printf('total false positives Iteration 3: %f\n', fptrain + fptest);
printf('total false negatives Iteration 3: %f\n', fntrain + fntest);



                                                  
