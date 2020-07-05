function [centroids] = clustering_pc(points, NC)
  % determinarea numarului de linii si coloane a
  % matricei de puncte D-dimensionale
  [N D] = size(points);
  % initializare lista de puncte
  cluster = zeros(NC);
  %iterator
  nr = zeros(NC);
  % formarea cluster-ului initial
  for i = 1 : NC
    for j = 1 : N
      if mod(j, NC) == i
        nr(i)++;
        for k = 1 : D
          cluster(nr(i), i, k) = points(j, k);
        endfor
      endif
    endfor
  endfor
  % cazul separat in cazul in care punctele mod NC dau 0
  for j = 1 : N
    if mod(j, NC) == 0
      nr(NC)++;
      for k = 1 : D
        % cluster care este in 3 dimensiuni
        cluster(nr(NC), NC, k) = points(j, k);
      endfor
    endif
  endfor
  % daca exista zone din lista in care niciun cluster nu a fost atribuit,
  % atunci se initializeaza cu 1
  for i = 1 : NC
    if nr(i) == 0
      nr(i) = 1;
    endif
  endfor
  % initializarea vecotului de centroizi, fiecare corespunzand ca indice
  % clusterului cu acelasi indice
  centroids = zeros(D);
  % formarea vectorului de centroizi
  for i = 1 : NC
    for k = 1 : D
      S = 0;
      for j = 1 : nr(i)
        S = cluster(j, i, k) + S;
      endfor
      centroids(i, k) = S / nr(i);
    endfor
  endfor
  % acum fac recalcularea centroizilor pana cand pozitia lor nu se mai schimba
  % basically este acelasi lucru pe care l-am facut anterior, dar pe care l-am
  % introdus intr-o bucla while cu conditia de oprire mentionata anterior 
  it = 0; centroids2 = zeros(NC, D);
  ok = 1;
  % while-ul de care spuneam
  while(ok != 0)
    ok = 0;
    % reiterarea
    if it!=0
      centroids = centroids2;
    endif
    % initializarea unei liste de clustere necesare
    cluster2 = zeros(N, NC);nr1 = zeros(NC);
    % alegerea unui alt vector de centroizi necesar verificarii
    centroids2 = zeros(NC, D);
    for l = 1 : N
      min = norm(points(l,:) - centroids(1, :));
      for j = 1 : NC
        % gruparea din nou a punctelor in functie de distanta minima
        % pana la  un centroid
        if min > norm(points(l,:) - centroids(j, :))
          min = norm(points(l,:) - centroids(j, :));
        endif
      endfor
      for k = 1 : NC
        if min == norm(points(l,:) - centroids(k, :))
          nr1(k)++;
          for a = 1 : D
            cluster2(nr1(k), k, a) = points(l, a);
          endfor
        endif
      endfor
    endfor
    % initializare cu 1
    for i = 1 : NC
      if nr1(i) == 0
        nr1(i) = 1;
      endif
    endfor
    % formarea centroizilor la pasul curent
    for i = 1 : NC
      for k = 1 : D
        S = 0;
        for j = 1 : nr1(i)
          S = cluster2(j, i, k) + S;
        endfor
        centroids2(i, k) = S / nr1(i);
      endfor
    endfor
    it++;
    % verificarea faptului ca centroizii s-au deplasat sau nu
    % in cazul in care centroizii s-au deplasat, atunci variabila ok devine
    % 1, iar iterarea continua
    for j = 1 : NC
      for i = 1 : D
        if centroids(j, i) != centroids2(j, i)
          ok = 1;
        endif
      endfor
    endfor
  endwhile
  % atribuirea finala, centroids2 fiind vectorul de centroizi la pozitia
  % curenta, iar centroids fiin vectorul de centroizi la pasul trecut
  centroids = centroids2;
endfunction