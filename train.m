function thetas = train(XTrain, yTrain, h, cs, num_c, idf)

% classifers
c = size(yTrain,2);
% samples
n = size(XTrain,1);
% words
f = size(XTrain,2);

thetas = zeros(num_c, f);

printf('re-weighting terms...\n');

tic;
for i=1:n
    if mod(i,100) == 0 printf('%d ', i);  fflush(stdout); end;

    x = XTrain(i,:);
    idx = find(x>0);
    x(idx) = log(x(idx)+1);
    x = x.*idf;

    d = norm(x);
    if d>0
        x = x/d;
    end

    XTrain(i,:) = x;
end
toc;

printf('training classifiers %d ~ %d\n', cs, cs+num_c-1);

tic;
printf('training classifier %d...\n', i+cs-1);
for i=1:num_c
    printf('%d ', i+cs-1);
    fflush(stdout);
    
    indices = find(yTrain(:,i+cs-1)==1);

    theta = sum(XTrain(indices,:));
    
    t_norm = norm(theta);
    
    if t_norm > 0
        theta = theta / t_norm;
    end
    
    thetas(i,:) = theta;
end

printf('\n');
toc;

end