function [values, colind, rowptr] = matrix_to_csr(A)
  % functie care imi trece o matrice in forma CSR
  [M N] = size(A);
  ok = 0; nr = 0; n = 0;
  % in aceste doua foruri iterez prin matrice
  % si verific pentru fiecare element daca este diferit de zeros
  for i = 1 : M
    for j = 1 : N
      % daca elementul este diferit de 0, atunci introduc informatia
      % necesara in fiecare din vectorii care caracterizeaza forma csr
      if(A(i, j) != 0)
        ok++;
        nr++;
        values(nr) = A(i, j);
        colind(nr) = j;
        if ok == 1
            n++;
            rowptr(n) = nr;
        endif
      endif
    endfor
    ok = 0;
  endfor
  n++;
  % pe ultima pozitie la rowptr trebuie pusa valoarea nr + 1
  rowptr(n) = nr + 1;
endfunction