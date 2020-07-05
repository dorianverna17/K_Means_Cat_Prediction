function [A, b] = generate_probabilities_system(rows)
  % initializarea matricei sistemului si vectorului care reprezinta solutiile
  % determinarea numarului de elemente din labirint
  N = rows * (rows + 1) / 2;
  b = zeros(N, 1); 
  b(N - rows + 1 : N, 1) = 1;
  A = zeros(N, N);
  % completarea liniilor corespunzatoare varfurilor triunghiului
  % care reprezinta labirintul 
  A(1, 1) = 4; A(1, 2) = -1; A(1, 3) = -1;
  A(N, N) = 4; A(N - rows + 1, N - rows + 1) = 4;
  A(N - rows + 1, N - rows + 2) = -1; A(N, N - 1) = -1;
  A(N, N - rows) = -1; A(N - rows + 1, N - 2 * rows + 2) = -1;
  % for-ul in care completez liniile elementelor care corespund ultimei
  % linii din labirint
  for j = N - rows + 2 : N - 1
    A(j, j) = 5;
    A(j, j - rows : j - rows + 1) = -1;
    A(j, j - 1) = -1; A(j, j + 1) = -1;
  endfor
  % indici pe care i-am considerat necesari in contextul iterarii
  i = 2; j = 1; ok = 1;
  % while-ul in care ma ocup de construirea celorlalte linii
  while i < N - rows + 1
    % aici ma ocup de liniile corespunzatoare elementelor de pe margini
    ok++;
    A(i, i) = 5; A(i, i + 1) = -1;
    A(i, i - ok + 1) = -1; A(i, i + ok) = -1;
    A(i, i + ok + 1) = -1;
    A(i + ok - 1, i + ok - 1) = 5;
    A(i + ok - 1, j + ok - 2) = -1; A(i + ok - 1, i + 2 * ok - 1) = -1;
    A(i + ok - 1, i + ok - 2) = -1; A(i + ok - 1, i + 2 * ok) = -1;
    % in acest for se intra daca conditia din if este indeplinita
    % si in el completez liniile sistemului care corespund elementelor care
    % nu se afla pe niciuna din marginile labirintului
    if i > 3
      for k = i + 1 : i + ok - 2
        A(k, k) = 6;
        A(k, k - 1) = -1;
        A(k, k + 1) = -1;
        A(k, k - ok) = -1;
        A(k, k - ok + 1) = -1;
        A(k, k + ok) = -1;
        A(k, k + ok + 1) = -1;
      endfor
    endif
    % atribuirea altor valori pentru indici pentru iterare
    aux = i;
    i = i + ok;
    j = aux;
  endwhile
endfunction