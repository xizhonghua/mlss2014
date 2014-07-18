#!/usr/bin/env octave -q
X = load('data/XTrain.mat');
y = load('data/yTrain.mat');

load('data/h.mat');
load('data/idf.mat');
load('data/relation.mat');

addpath('handout/code');

xdata = X.XTrain;
ydata = y.yTrain;

n = size(xdata, 1);
f = size(xdata, 2);
c = size(ydata, 2);

trainning = 0;
combine_parameters = 0;
testing = 0;
training_percent = 0.7;

start_index = 1;
num_class = c;

arg_list = argv ();
for i = 1:nargin
    if strcmp(arg_list{i}, '-t') == 1
        trainning = 1;
    elseif strcmp(arg_list{i}, '-s') == 1
        start_index = str2num(arg_list{i+1});
    elseif strcmp(arg_list{i}, '-n') == 1
        num_class = str2num(arg_list{i+1});
    elseif strcmp(arg_list{i}, '-c') == 1
        testing = 1;
    elseif strcmp(arg_list{i}, '-e') == 1
        combine_parameters = 1;
    elseif strcmp(arg_list{i}, '-p') == 1
        training_percent = str2num(arg_list{i+1});
    end
end

training_percent
train_size = int16(n*training_percent)
test_size = n - train_size

XTrain = xdata(1:train_size,:);
XTest = xdata(train_size+1:n,:);
yTrain = ydata(1:train_size,:);
yTest = ydata(train_size+1:n,:);

if trainning == 1
    thetas = train(XTrain, yTrain, h, start_index, num_class, idf);
    thetas_s = sparse(thetas);
    save('-mat7-binary', '-z', './handout/code/parameters.txt', 'thetas_s', 'relation', 'idf');
end

if testing == 1
    c = classify(XTrain, yTrain, XTest, h);
    result = Evaluate(yTest, c);
end
