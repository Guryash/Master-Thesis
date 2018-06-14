function p = Script5_predict(X, theta, inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize) %p = PREDICT(X, theta, inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize) computes the predictions for X using a threshold at 0.5

%----- 1a.variables declartion
m = size(X, 1); %number of training examples = 569
p = zeros(m, 1); %calculate prediction value 

%----- 1b. to reshape theta into weights for different layers
W1 = reshape(theta(1: hiddenLayer1Size*inputSize), hiddenLayer1Size, inputSize);
%size(W1) %-- 10 15

W2 = reshape(theta(hiddenLayer1Size*inputSize + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size)), hiddenLayer2Size, hiddenLayer1Size);
%size(W2) %-- 10 10

W3 = reshape(theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize)), outputSize, hiddenLayer2Size);
%size(W3) %-- 1 10

b1 = theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + hiddenLayer1Size);
%size(b1) %-- 10 1

b2 = theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + hiddenLayer1Size + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + hiddenLayer1Size + hiddenLayer2Size);
%size(b2) %-- 10 1

b3 = theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + hiddenLayer1Size + hiddenLayer2Size + 1: end);
%size(b3) %-- 1 1


%----- 2a.calculating layer 2 activations
activation2 = zeros(size(W1,1), size(X,1));

activation2 = (W1 * X') + b1;
activation2 = sigmoid(activation2); %-- final activation of layer 2
%size(activation2) %-- 10 569

%----- 2b. calculating layer 3 activations
activation3 = zeros(size(W2,1), size(activation2,2));

activation3 = (W2 * activation2) + b2;
activation3 = sigmoid(activation3); %-- final activation of layer 3
%size(activation3) %-- 10 569

%----- 2c. calculating layer 4 activations
activation4 = zeros(size(W3,1), size(activation3,2));

activation4 = (W3 * activation3) + b3;
activation4 = sigmoid(activation4); %-- final activation of layer 3
%size(activation4) %-- 1 569


%----- 3. calculating p
values = activation4';

for i=1:m
    if values(i) >= 0.5
	p(i) = 1;
    end
end

end

%----- 0. sigmoid function implementation
function sigm = sigmoid(x)
    sigm = 1 ./ (1 + exp(-x));
end


