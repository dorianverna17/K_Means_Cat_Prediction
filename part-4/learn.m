function [w] = learn(X, y, lr, epochs)
  % functia care implementeaza invatarea vectorului w
  [n m] = size(X);
  batch_size = 64;
  % aici initializez w cu o serie de valori random
  w = randperm(100, m + 1)/9000;
  w = w';
  v = zeros(n, 1);
  % aici scalez coloanele din X
  for i = 1 : m
    X(:, i) = (X(:, i) - mean(X(:, i))) / std(X(:, i));
  endfor
  % aici formez X tilda
  X1 = [X v];
  % aici generez mai multe linii random 
  % aici aplic algoritmul dat in pdf
  for epoch = 1 : epochs
    % aici generez batch_size linii random
    s = randperm(batch_size);
    [a b] = size(s);
    suma = 0;
    s = s';
    % aici formez X_batch si y_batch 
    for j = 1 : batch_size
      X2(s(j, 1), :) = X1(s(j, 1), :);
      y2(s(j), :) = y(s(j), :);
    endfor
    % aici am un for pt a calcula suma pe care o folosesc in formula lui w(i, 1) 
    for j = 1 : batch_size
      suma = suma + (X2(j, :) * w - y2(j)) * X2(j, i);
    endfor
    % aici il calculez pe w(i, 1);
    w(i, 1) = w(i, 1) - lr / n * suma;
  endfor
endfunction