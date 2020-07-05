function [x] = SST(A, b)
  % determinarea dimensiunilor matricei
  [n m] = size(A);
  % calcularea ultimului element din vectorul solutie
  x(m) = double(b(m)) / A(m, m);
  % structura repetitiva in care se calculeaza restul vectorului x
  for j = m - 1 : -1 : 1
    s = 0;
    % suma solutiilor care deja sunt stiute (de pe linia pe care s-a ajuns)
    for k = j + 1 : m
      % calculul acestei sume
      s = s + A(j, k) * x(k);
    endfor
    % calculul componentei j a vectorului de solutii
    x(j) = double((b(j) - s)) / A(j, j);
  endfor
endfunction