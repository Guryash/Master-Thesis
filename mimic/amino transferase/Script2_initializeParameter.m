function theta = Script2_initializeParameter(inputSize, hiddenLayer1Size, outputSize)

%% Initialize parameters randomly based on layer sizes.
r  = sqrt(6) / sqrt(hiddenLayer1Size+inputSize+1);  %we'll choose weights uniformly from the interval [-r, r] r= 0.48038 %
W1 = rand(hiddenLayer1Size, inputSize) * 2 * r - r;
W2 = rand(outputSize, hiddenLayer1Size) * 2 * r - r;

b1 = zeros(hiddenLayer1Size, 1);
b2 = zeros(outputSize, 1);

% Convert weights and bias gradients to the vector form.
% This step will "unroll" (flatten and concatenate together) all 
% your parameters into a vector, which can then be used with minFunc. 
theta = [W1(:) ; W2(:) ; b1(:) ; b2(:)];

end

