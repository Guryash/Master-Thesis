function [cost,grad] = Script3_sparseAutoencoder_tanh(theta, inputSize, hiddenLayer1Size, hiddenLayer2Size, outputSize, data, y, lambda)

%----- 1. to reshape theta into weights for different layers
W1 = reshape(theta(1: hiddenLayer1Size*inputSize), hiddenLayer1Size, inputSize);
%size(W1) %-- 10 15 %-- 25 15

W2 = reshape(theta(hiddenLayer1Size*inputSize + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size)), hiddenLayer2Size, hiddenLayer1Size);
%size(W2) %-- 10 10

W3 = reshape(theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize)), outputSize, hiddenLayer2Size);
%size(W3) %-- 1 10

b1 = theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + hiddenLayer1Size);
%size(b1) %-- 10 1 %15 1

b2 = theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + hiddenLayer1Size + 1: (hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + hiddenLayer1Size + hiddenLayer2Size);
%size(b2) %-- 10 1

b3 = theta((hiddenLayer1Size*inputSize) + (hiddenLayer1Size*hiddenLayer2Size) + (hiddenLayer2Size*outputSize) + hiddenLayer1Size + hiddenLayer2Size + 1: end);
%size(b3) %-- 1 1

m = size(data,1); %number of training example = 569


%----- 2. defining actual variables that are to be computed
cost = 0;
W1grad = zeros(size(W1)); 
W2grad = zeros(size(W2));
W3grad = zeros(size(W3));
b1grad = zeros(size(b1));
b2grad = zeros(size(b2)); 
b3grad = zeros(size(b3));


%----- 3a. calculating layer 2 activations
activation2 = zeros(size(W1,1), size(data,1));

activation2 = (W1 * data') + b1;
activation2 = tangent(activation2); %-- final activation of layer 2
%size(activation2) %-- 10 569 %-- 25 569

%----- 3b. calculating layer 3 activations
activation3 = zeros(size(W2,1), size(activation2,2));

activation3 = (W2 * activation2) + b2;
activation3 = tangent(activation3); %-- final activation of layer 3
%size(activation3) %-- 10 569

%----- 3c. calculating layer 4 activations
activation4 = zeros(size(W3,1), size(activation3,2));

activation4 = (W3 * activation3) + b3;
activation4 = tangent(activation4); %-- final activation of layer 3
%size(activation4) %-- 1 569


%----- 4. calcualting cost
%----- 4a. calcualting cost without regularisation
cost_temp = 0;
for i = 1:size(activation3,2)
    cost_temp = cost_temp + ((1/2)*((activation4(i) - y(i)).^2));
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

addW3 = 0;
for i  = 1:size(W3, 1)
  for j = 1:size(W3, 2)
    addW3 = addW3 + W3(i, j)^2;
  end 
end

cost = cost + (lambda/2)*(addW1 + addW2 + addW3); % cost = 0.11953 -- calculated cost


%----- 5. using back propagation algorithm to compute gradients
%----- 5a. calculating error term for layer 4
delta4 = -(y' - activation4).* (1-(activation4.^2));
%size(delta4) %-- 1 569

%----- 5b. calculating error term for layer 3
delta3 = (W3'*delta4) .* (1-(activation3.^2)); 
%size(delta3) %-- 10 569

%----- 5c. calculating error term for layer 2
delta2 = (W2'*delta3) .* (1-(activation2.^2));
%size(delta2) %-- 10 569

%----- 5e. calculating gradients for layer 3
W3grad = ((1/m)*delta4*activation3') + (lambda*W3);
%size(W3grad) %-- 1 10

b3grad = (1/m)*sum(delta4, 2);
%size(b3grad) %-- 1 1

%----- 5e. calculating gradients for layer 2
W2grad = ((1/m)*delta3*activation2') + (lambda*W2);
%size(W2grad) %-- 10 10

b2grad = (1/m)*sum(delta3, 2);
%size(b2grad) %-- 10 1

%----- 5f. calculating gradients for layer 1
W1grad = ((1/m)*delta2*data) + (lambda*W1);
%size(W1grad) %-- 10 15

b1grad = (1/m)*sum(delta2, 2);
%size(b1grad) %-- 10 1

%----- 5g. unrolling gradients into a single matrix
grad = [W1grad(:) ; W2grad(:) ; W3grad(:) ; b1grad(:) ; b2grad(:) ; b3grad(:)];
%size(grad) %-- 281 1

%----- 6. calculating new weights
W3 = W3 - W3grad;

b3 = b3 - b3grad;

W2 = W2 - W2grad;

b2 = b2 - b2grad;

W1 = W1 - W1grad;

b1 = b1 - b1grad;

end

%----- 0. sigmoid function implementation
function tang = tangent(x)
    tang = (exp(x) - exp(-x)) ./ (exp(x) + exp(-x));
end



