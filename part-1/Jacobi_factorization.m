function [G_J c_J] = Jacobi_factorization(A, b)
  % functie care imi intoarce matricea de iteratie
  % si vectorul de iteratie
  % calculez matricea diagonala D
  % si matricele inferior si superior triunghiulare L si U
  D = diag(diag(A));
  L = tril(A) - D;
  U = triu(A) - D;
  % matricele N si P le folosesc pentru calcul
  N = D;
  P = L + U;
  % matrice de iteratie
  G_J = -inv(N) * P;
  % vector de iteratie
  c_J = inv(N) * b;
endfunction