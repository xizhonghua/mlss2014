load('data/XTrain.mat');
load('data/yTrain.mat');

[m,n] = size(XTrain);
c = size(yTrain, 2);

relation = zeros(c,c);

for i=1:m
    if mod(i, 100) == 0 printf('%d ',i); fflush(stdout); end;
    idx = find(yTrain(i,:));
    s = size(idx, 2);
    for p=1:s-1
        for q=p+1:s
            relation(idx(p),idx(q)) = relation(idx(q),idx(p)) = 1; 
        end
    end
end

relation = sparse(relation);

save('-z', 'data/relation.mat', 'relation');

