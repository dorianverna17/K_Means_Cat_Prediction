function [X y] = preprocess(path_to_dataset, histogram, count_bins)
  % aici este aceeasi functie de la task-ul 3
  path_to_dataset1 = strcat(path_to_dataset, "cats/");
  path_to_dataset2 = strcat(path_to_dataset, "not_cats/");
  path_to_imgs1 = strcat( path_to_dataset1,  '*jpg');
  path_to_imgs2 = strcat( path_to_dataset2,  '*jpg');
  img_files1 = dir(path_to_imgs1);
  img_files2 = dir(path_to_imgs2);
  n1 = length(img_files1);
  n2 = length(img_files2);
  X = zeros(n1 + n2, 3 * count_bins);
  y = ones(n1 + n2, 1);
  D = 1:10;
	imgs(1:n1, D) = 0;
	for i = 1:n1
		l = 1:length(img_files1(i).name);
		imgs(i, l) = img_files1(i).name;
	end
	imgs = char(imgs);
  if strcmp(path_to_dataset1, "dataset/cats/") == 1
    y(1 : n1, 1) = 1;
  elseif strcmp(path_to_dataset1, "dataset/not_cats/") == 1
    y(1 : n1, 1) = -1
  endif
  for i = 1:n1
    da = path_to_dataset1;
    yes = strcat(da, imgs(i, :));
    if strcmp(histogram, "HSV") == 1
      [sol] = hsvHistogram(yes, count_bins);
    elseif strcmp(histogram, "RGB") == 1
      [sol] = rgbHistogram(yes, count_bins);
    endif
    X(i, :) = sol;
  endfor
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
    yes = strcat(da, imgs(i, 1:length(img_files2(i).name)));
    if strcmp(histogram, "HSV") == 1
      [sol] = hsvHistogram(yes, count_bins);
    elseif strcmp(histogram, "RGB") == 1
      [sol] = rgbHistogram(yes, count_bins);
    endif
    X(i + n1, :) = sol;
  endfor
endfunction