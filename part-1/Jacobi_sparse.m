function [x] = Jacobi_sparse(G_values, G_colind, G_rowptr, c, tol)
  % functia care se ocupa de rezolvarea sistemului
  % scot dimensiunile matricei sistemului
  [n m] = size(G_rowptr);
  % aproximarea initiala a solutiei
  x0 = zeros(m - 1);
  % dau un numar maxim de iteratii la care sa se opreasca programul
  % am observat ca pentru acest numar toate testele vor trece
  iter = 0; max_iter = 900;
  while iter < max_iter
    % folosesc formula de iteratie
    x = c + csr_multiplication(G_values, G_colind, G_rowptr, x0);
    % conditia de iesire in caz ca s-a intalnit solutia
    if(norm(x-x0,inf)/norm(x,inf)<=tol)  
      break;
    endif
    iter = iter + 1;
    % dam o noua valoare pentru iteratie
    x0=x;
  endwhile
endfunction
