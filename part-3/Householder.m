function [Q R] = Householder(A)
  % Aceasta este functia care imi rezolva sistemul
  % am folosit elemente din implementarea de la curs
  % (de pe acs) si de la laborator
  [m n] = size(A);
  Q = eye(m);
  % in acest for voi aplica reflectorii Householder
  % asupra matricei A si voi forma Q si R
  for p = 1 : min(m - 1, n)
    % calculez sigma
    suma = 0;
    for i = p : m;
      suma = suma + A(i, p) * A(i, p);
    endfor
    sigma = -sign(A(p, p)) * sqrt(suma);
    % formez vectorul Householder
    v = zeros(1, m);
    v(1, p) = A(p, p) + sigma;
    v(1, p + 1 : m) = A(p + 1 : m, p);
    v = v';
    beta = sigma * v(p);
    % acum schimb matricea A
    A(p, p) = -sigma;
    for i = p + 1 : m
      A(i, p) = 0;
    endfor
    for j = p + 1 : n
      A(p : m, j) = A(p : m, j) - ...
      v(p : m) * v(p : m)' * A(p : m, j) / beta;
    endfor
    % acum schimb pe Q
    for j = 1 : m
      Q(p : m, j) = Q(p : m, j) - ...
      v(p : m) * v(p : m)' * Q(p : m, j) / beta;
    endfor
  endfor
  Q = Q';
  R = A;
endfunction