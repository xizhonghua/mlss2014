#!/usr/bin/env octave -q
load('./data/XTrain.mat');

size_d = size(XTrain, 1);
size_w = size(XTrain, 2);

idf = zeros(1, size_w);

for i=1:size_w
    idf(i) = nnz(XTrain(:,i));
    if idf(i) > 0
        idf(i) = log(size_d/idf(i));
    end
end

idf = sparse(idf);

save('-z','data/idf.mat', 'idf');