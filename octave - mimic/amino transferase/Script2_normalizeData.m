function normalizedData = Script2_normalizeData(data)

% Squash data to [0.1, 0.9] since we use sigmoid as the activation function in the output layer

% Remove DC (mean of values). 
normalizedData = bsxfun(@minus, data, mean(data));

% Truncate to +/-3 standard deviations and scale to -1 to 1
pstd = 3 * std(normalizedData(:));
normalizedData = max(min(normalizedData, pstd), -pstd) / pstd;

% Rescale from [-1,1] to [0.1,0.9]
normalizedData = (normalizedData + 1) * 0.4 + 0.1;

end
