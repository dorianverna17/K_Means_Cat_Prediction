function [X y] = preprocess(path_to_dataset, histogram, count_bins)
  % calea catre fisierul cu pisici
  path_to_dataset1 = strcat(path_to_dataset, "cats/");
  % calea catre fisierul fara pisici
  path_to_dataset2 = strcat(path_to_dataset, "not_cats/");
  % calea catre imaginile din fisierul cu pisici
  path_to_imgs1 = strcat( path_to_dataset1,  '*jpg');
  % calea catre imaginile din fisierul fara pisici
  path_to_imgs2 = strcat( path_to_dataset2,  '*jpg');
  % luam lista imaginilor din fiecare path
  img_files1 = dir(path_to_imgs1);
  img_files2 = dir(path_to_imgs2);
  % pe baza listelor de imagini, calculam numarul de imagini din fiecare path
  n1 = length(img_files1);
  n2 = length(img_files2);
  % initializarea matricei de caracteristici
  X = zeros(n1 + n2, 3 * count_bins);
  % initializarea vectorului de etichete
  y = ones(n1 + n2, 1);
  %iterator prin lungimea numelui unei imagini
  D = 1:10;
  % form unui vector al numelor imaginilor
  % prima oara formam liniile cu ajutorul pozelor din cats
	imgs(1:n1, D) = 0;
  % formarea acestui vector
	for i = 1:n1
		l = 1:length(img_files1(i).name);
		imgs(i, l) = img_files1(i).name;
	end
	imgs = char(imgs);
  % daca este setul de date cu pisici, atunci componentele
  % aferente vectorului de etichete sunt 1
  if strcmp(path_to_dataset1, "dataset/cats/") == 1
    y(1 : n1, 1) = 1;
  % daca este setul de date fara pisici, atunci componentele
  % aferente vectorului de etichete sunt 1
  elseif strcmp(path_to_dataset1, "dataset/not_cats/") == 1
    y(1 : n1, 1) = -1
  endif
  % in acest for iau fiecare vector sol si il introduc in matricea X
  for i = 1:n1
    da = path_to_dataset1;
    yes = strcat(da, imgs(i, :));
    % daca se cere histograma HVS, fac cu hsvHistogram
    if strcmp(histogram, "HSV") == 1
      [sol] = hsvHistogram(yes, count_bins);
    % daca se cere histograma RGB, fac cu rgbHistogram
    elseif strcmp(histogram, "RGB") == 1
      [sol] = rgbHistogram(yes, count_bins);
    endif
    % introducerea vectorului in X
    X(i, :) = sol;
  endfor
  % in acelasi mod se procedeaza si pentru datasetul pentru not_cats
  % urmatoarele linii din X se formeaza cu ajutorul histogramelor in not_cats
  % este acelasi algoritm pe care l-am folosit inainte
  imgs(1:n2, D) = 0;
	for i = 1:n2
		l = 1:length(img_files2(i).name);
		imgs(i, l) = img_files2(i).name;
	end
	imgs = char(imgs);
  if strcmp(path_to_dataset2, "dataset/cats/") == 1
    y(n1 + 1 : n1 + n2, 1) = 1;
  elseif strcmp(path_to_dataset2, "dataset/not_cats/") == 1
    y(n1 + 1 : n1 + n2, 1) = -1;
  endif
  for i = 1:n2
    da = path_to_dataset2;
    yes = strcat(da, imgs(i, :));
    if strcmp(histogram, "HSV") == 1
      [sol] = hsvHistogram(yes, count_bins);
    elseif strcmp(histogram, "RGB") == 1
      [sol] = rgbHistogram(yes, count_bins);
    endif
    X(i + n1, :) = sol;
  endfor
endfunction