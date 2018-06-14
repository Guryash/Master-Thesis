function numgrad = Script4_gradientChecking(J, theta)
% theta: a vector of parameters
% J: a function that outputs a real-number. Calling y = J(theta) will return the function value at theta.

numgrad = zeros(size(theta));
epsilon = 0.0001;

for i = 1:size(theta)
  evector = zeros(size(theta));
  evector(i) = 1;
  numgrad(i) = (J(theta + (evector*epsilon)) - J(theta - (evector*epsilon)))/(2*epsilon);
  
end

end
