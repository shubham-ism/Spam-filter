
% Spam Classification with SVMs

%% Initialization  
clear ; close all; clc

%% ==================== Part 1: Email Preprocessing ====================
% SVM to classify emails into Spam.
 
fprintf('\nPreprocessing sample email (emailSample1.txt)\n');

% Extract Features
file_contents = readFile('emailSample1.txt');
word_indices  = processEmail(file_contents);

% Print Stats
fprintf('Word Indices: \n');
fprintf(' %d', word_indices);
fprintf('\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ==================== Part 2: Feature Extraction ====================
%  convert each email into a vector of features in R^n. 


fprintf('\nExtracting features from sample email (emailSample1.txt)\n');

% Extract Features
file_contents = readFile('emailSample1.txt');
word_indices  = processEmail(file_contents);
features      = emailFeatures(word_indices);

% Print Stats
fprintf('Length of feature vector: %d\n', length(features));
fprintf('Number of non-zero entries: %d\n', sum(features > 0));

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== Part 3: Train Linear SVM for Spam Classification ========
%  linear classifier to determine if an
%  email is Spam or Not-Spam.

% Load the Spam Email dataset
load('spamTrain.mat');

fprintf('\nTraining Linear SVM (Spam Classification)\nUsing Provided Data Set')
fprintf('(this may take 1 to 2 minutes) ...\n')

%C = 0.1;
%model = svmTrain(X, y, C, @linearKernel);

C = 1; sigma = 0.1;
model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));

p = svmPredict(model, X); 

fprintf('Training Accuracy: %f\n', mean(double(p == y)) * 100);

%% =================== Part 4: Test Spam Classification ================
% Load the test dataset

load('spamTest.mat');

fprintf('\nEvaluating the trained Linear SVM on a test set ...\n')

p = svmPredict(model, Xtest);

fprintf('Test Accuracy: %f\n', mean(double(p == ytest)) * 100);
pause;



%% =================== Part 5: Try my Own Emails =====================
%  I can use it on my own email.
filename = 'example.txt';

% Read and predict
file_contents = readFile(filename);
word_indices  = processEmail(file_contents);
x             = emailFeatures(word_indices);
p = svmPredict(model, x);

fprintf('\nProcessed %s\n\nSpam Classification: %d\n', filename, p);
fprintf('(1 indicates spam, 0 indicates not spam)\n\n');

