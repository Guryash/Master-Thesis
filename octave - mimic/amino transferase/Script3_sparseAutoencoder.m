function [cost,grad] = Script3_sparseAutoencoder(theta, inputSize, hiddenLayer1Size, outputSize, data, y, lambda)

%----- 1. to reshape theta into weights for different layers
W1 = reshape(theta(1: hiddenLayer1Size*inputSize), hiddenLayer1Size, inputSize);
%size(W1) %-- 10 15

W2 = reshape(theta(hiddenLayer1Size*inputSize + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*outputSize)), outputSize, hiddenLayer1Size);
%size(W2) %-- 1 10

b1 = theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*outputSize) + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*outputSize) + hiddenLayer1Size);
%size(b1) %-- 10 1

b2 = theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*outputSize) + hiddenLayer1Size + 1: end);
%size(b2) %-- 1 1

m = size(data,1); %number of training example = 569


%----- 2. defining actual variables that are to be computed
cost = 0;
W1grad = zeros(size(W1)); 
W2grad = zeros(size(W2));
b1grad = zeros(size(b1));
b2grad = zeros(size(b2)); 


%----- 3a. calculating layer 2 activations
activation2 = zeros(size(W1,1), size(data,1));

activation2 = (W1 * data') + b1;
activation2 = sigmoid(activation2); %-- final activation of layer 2
%size(activation2) %-- 10 569

%----- 3b. calculating layer 3 activations
activation3 = zeros(size(W2,1), size(activation2,2));

activation3 = (W2 * activation2) + b2;
activation3 = sigmoid(activation3); %-- final activation of layer 3
%size(activation3) %-- 1 569


%----- 4. calcualting cost
%----- 4a. calcualting cost without regularisation
cost_temp = 0;
for i = 1:size(activation3,2)
    cost_temp = cost_temp + ((1/2)*((activation3(i) - y(i)).^2));
end

cost = (1/m)*cost_temp;  

%----- 4b. adding regularisation component to the cost
addW1 = 0;
for i  = 1:size(W1, 1)
  for j = 1:size(W1, 2)
    addW1 = addW1 + W1(i, j)^2;
  end 
end

addW2 = 0;
for i  = 1:size(W2, 1)
  for j = 1:size(W2, 2)
    addW2 = addW2 + W2(i, j)^2;
  end 
end

cost = cost + (lambda/2)*(addW1 + addW2); % cost = 0.12596 -- calculated cost


%----- 5. using back propagation algorithm to compute gradients
%----- 5a. calculating error term for layer 3
delta3 = -(y' - activation3).* activation3 .* (1-activation3);
%size(delta3) %-- 1 569

%----- 5b. calculating error term for layer 2
delta2 = (W2'*delta3) .* activation2 .* (1-activation2); 
%size(delta2) %-- 10 569

%----- 5c. calculating gradients for layer 2
W2grad = ((1/m)*delta3*activation2') + (lambda*W2);
%size(W2grad) %-- 1 10

b2grad = (1/m)*sum(delta3, 2);
%size(b2grad) %-- 1 1

%----- 5d. calculating gradients for layer 1
W1grad = ((1/m)*delta2*data) + (lambda*W1);
%size(W1grad) %-- 10 15

b1grad = (1/m)*sum(delta2, 2);
%size(b1grad) %-- 10 1

%----- 5e. unrolling gradients into a single matrix
grad = [W1grad(:) ; W2grad(:) ; b1grad(:) ; b2grad(:)];
%size(grad) %-- 171 1

%----- 6. calculating new weights
W2 = W2 - W2grad;

b2 = b2 - b2grad;

W1 = W1 - W1grad;

b1 = b1 - b1grad;

end

%----- 0. sigmoid function implementation
function sigm = sigmoid(x)
    sigm = 1 ./ (1 + exp(-x));
end



