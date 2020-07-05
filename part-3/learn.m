function [w] = learn(X, y)
  % functia de realizare a vectorului w
  [n m] = size(X);
  % v este coloana de 1 pe care o adaug la X ca acesta sa devina X tilda
  v = ones(n, 1);
  X = [X v];
  % aplic Householder
  [Q R] = Householder(X);
  % acum aplic SST
  b = Q' * y;
  w = SST(R, b);
endfunction