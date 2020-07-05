function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  % aici fromez calea catre folderul cu poze cu pisici
  path_to_cat = strcat(path_to_testset, "cats/");
  path_to_imgs = strcat( path_to_cat, '*jpg');
  % aici iau imaginile de la path-ul dat ca parametrii
  img_files = dir(path_to_imgs);
  % vad care e numarul de imagini
  n = length(img_files);
  D = 1:10;
	imgs(1:n, D) = 0;
  % calculez vectorul de nume al imaginilor
  for i = 1:n
		l = 1:length(img_files(i).name);
		imgs(i, l) = img_files(i).name;
	end
	imgs = char(imgs);
  nr = 0;
  % fac histograma fiecarei poze
  for i = 1:n
    da = path_to_cat;
    yes = strcat(da, imgs(i, :));
    if strcmp(histogram, "HSV") == 1
      x = hsvHistogram(yes, count_bins);
    elseif strcmp(histogram, "RGB") == 1
      x = rgbHistogram(yes, count_bins);
    endif
    x(1, 3 * count_bins + 1) = 1;
    % aici calculez y1
    % daca y1 este mai mare decat 0, atunci poza este cu pisica
    y1 = w * x';
    % verificam daca poza a fost clasificata ca fiind cu pisici
    % caz in care marim numarul de poze clasificate corect (nr)
    if(y1 > 0)
      nr++;
    endif
  endfor
  % salvam numraul de poze din primul set in n1
  n1 = n;
  % facem acelasi algoritm pentru directorul not_cats
  path_to_cat = strcat(path_to_testset, "not_cats/");
  path_to_imgs = strcat( path_to_cat, '*jpg');
  img_files = dir(path_to_imgs);
  n = length(img_files);
  D = 1:10;
	imgs(1:n, D) = 0;
	% salvam numele imaginilor intr-un vector
  for i = 1:n
		l = 1:length(img_files(i).name);
		imgs(i, l) = img_files(i).name;
	end
	imgs = char(imgs);
  % calculez histogramele
  for i = 1:n
    da = path_to_cat;
    yes = strcat(da, imgs(i, :));
    if strcmp(histogram, "HSV") == 1
      x = hsvHistogram(yes, count_bins);
    elseif strcmp(histogram, "RGB") == 1
      x = rgbHistogram(yes, count_bins);
    endif
    x(1, 3 * count_bins + 1) = 1;
    % calulez y1
    y1 = w * x';
    % daca y1 este mai mic decat 0, atunci poza a fost
    % clasificata bine ca neavand pisica, deci marim numarul nr
    if(y1 < 0)
      nr++;
    endif
  endfor
  % aici calculam nr
  percentage = nr/(n1 + n);
endfunction