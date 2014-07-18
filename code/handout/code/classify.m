function [c] = classify(XTrain, yTrain, XTest, h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% ------ START: REPLACE WITH YOUR CODE ------
load('parameters.txt');

n = size(XTest,1);
nClass = size(yTrain,2);
c = zeros(n, nClass);

tic;

printf('classifying...\n');

K = 5;

for i=1:n
    if mod(i,100) == 0 printf('%d ',i); end;
    fflush(stdout);
    
    x = XTest(i,:);
    idx = find(x>0);
    x(idx) = log(x(idx)+1);
    x = x.*idf;
    
    s = x*thetas_s';
    
    [sortedValues,sortIndex] = sort(s,'descend');
    
    idx = sortIndex(1:K);  
    ms = sortedValues(1:K);
   
    c(i, idx(1)) = 1;

    if relation(idx(1), idx(2)) > 0 && ms(2) * 1.25 > ms(1)
        c(i, idx(2)) = 1;
    end

    if (relation(idx(1), idx(3)) > 0 && relation(idx(2), idx(3)) > 0 ) && ms(3) * 1.05 > ms(1)
        c(i, idx(3)) = 1;
    end

end
printf('\n');
toc;


% ------ END: REPLACE WITH YOUR CODE ------



end


