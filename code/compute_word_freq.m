function freq = word_freq(X)

n = size(X,1);
f = size(X,2);
freq = zeros(f,1);
for i=1:f
    freq(i) = full(sum(X(:,i)));
end

end