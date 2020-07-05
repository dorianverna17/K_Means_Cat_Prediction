function [cost] = compute_cost_pc(points, centroids)
  % functie de calculare a costului
  % determinarea numarului de centroizi (NC)
  [NC k] = size(centroids);
  % determinarea numarului de dimensiuni a punctelor
  % si numarul acestora
  [N D] = size(points);
  % initializarea costului
  cost = 0;
  % initializarea vectorului de distante euclidiene
  norm1 = zeros(NC);
  % for-ul in care se calculeaza costul
  for i = 1 : N
    % in acest for se introduc valori in vectorul de distante euclidiene
    for j = 1 : NC
      norm1(j) = norm(points(i, :) - centroids(j, :));
    endfor
    % q este minimul acestui vector
    q = min(norm1);
    % for- ul in care se verifica daca punctul i corespunde centroidului sau
    % (distanta euclidiana dintre el si centroid este q) 
    for j = 1 : NC
      if(norm(points(i, :) - centroids(j, :)) == q(1))
        % calcularea costului
        cost = cost + norm(points(i, :) - centroids(j, :));
      endif
    endfor
  endfor
endfunction