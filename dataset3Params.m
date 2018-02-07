function [C, sigma] = dataset3Params(X, y, Xval, yval)

C = 1;
sigma = 0.3;
pmn = size(yval);
a = [.01,.03,.1,.3,1,3,10,30];


for i = a
    for j = a
        model= svmTrain(X, y, i, @(x1, x2) gaussianKernel(x1, x2, j));
        predictions = svmPredict(model, Xval);
        mn = mean(double(predictions ~= yval));
        
        if mn < pmn
            pmn = mn;
            C = i;
            sigma = j;
        end
    end
end
            


% =========================================================================

end
