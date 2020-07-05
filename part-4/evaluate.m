function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  % aici este basically aceeasi functie ca la task-ul 3, doar ca
  % aici a trebuit sa formez din nou X (matricea de caracteristici)
  % diferenta fata de task-ul 3 este ca aici trebuie sa scalez X
  % aici citesc path-ul catre cats
  path_to_cat = strcat(path_to_testset, "cats/");
  path_to_imgs = strcat( path_to_cat, '*jpg');
  img_files = dir(path_to_imgs);
  n = length(img_files);
  D = 1:10;
	imgs(1:n, D) = 0;
	for i = 1:n
		l = 1:length(img_files(i).name);
		imgs(i, l) = img_files(i).name;
	end
	imgs = char(imgs);
  nr = 0;
  for i = 1:n
    da = path_to_cat;
    yes = strcat(da, imgs(i, :));
    if strcmp(histogram, "HSV") == 1
      x = hsvHistogram(yes, count_bins);
    elseif strcmp(histogram, "RGB") == 1
      x = rgbHistogram(yes, count_bins);
    endif
    % formam primele linii din X cu histogramele calculate pentru cats
    X(i, :) = x;
  endfor
  n1 = n;
  % aici citesc path-ul catre not_cats
  path_to_cat = strcat(path_to_testset, "not_cats/");
  path_to_imgs = strcat( path_to_cat, '*jpg');
  img_files = dir(path_to_imgs);
  n = length(img_files);
  D = 1:10;
	imgs(1:n, D) = 0;
	for i = 1:n
		l = 1:length(img_files(i).name);
		imgs(i, l) = img_files(i).name;
	endfor
	imgs = char(imgs);
  for i = 1:n
    da = path_to_cat;
    yes = strcat(da, imgs(i, :));
    if strcmp(histogram, "HSV") == 1
      x = hsvHistogram(yes, count_bins);
    elseif strcmp(histogram, "RGB") == 1
      x = rgbHistogram(yes, count_bins);
    endif
    % Completam X cu histogramele ramase
    X(i + n1, :) = x;
endfor
  % Acum scalam matricea X
  [q p] = size(X); 
  v = ones(q, 1);
  for i = 1 : p
    X(:, i) = (X(:, i) - mean(X(:, i))) / std(X(:, i));
  endfor
  % Formam matricea tilda cu o coloana de 1
  X = [X v];
  for i = 1 : q
    % calculam y1
    y1 = w' * X(i, :)';
    % pentru primele n1 linii, daca y1 este mai mare decat 0, atunci poza
    % cu pisica a fost clasificata bine, deci marim nr  
    if(y1 > 0 && i <= n1)
      nr++;
    endif
    % pentru primele liniile mai mari de n1, daca y1 este mai mic decat 0,
    % atunci poza fara pisica a fost clasificata bine, deci marim nr
    if(y1 < 0 && i > n1)
      nr++;
    endif
  endfor
  % aici calculez procentajul
  percentage = nr/(n1 + n);
endfunction