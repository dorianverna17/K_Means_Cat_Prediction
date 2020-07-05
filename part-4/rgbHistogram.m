function [sol] = rgbHistogram(path_to_image, count_bins)
  % aici am copiat functia de la task-ul 3
  img = imread(path_to_image);
  t = linspace(0, 256, count_bins + 1);
  img(:, :, 1);
  [a1, b1] = histc(img(:, :, 1), t);
  [a2, b2] = histc(img(:, :, 2), t);
  [a3, b3] = histc(img(:, :, 3), t);
  sol = zeros(1, 3 * count_bins); nr = 1;
  for i = 1 : count_bins
    sol(1, i) = sum(a1(i, :));
    sol(1, i + count_bins) = sum(a2(i, :));
    sol(1, i + 2 * count_bins) = sum(a3(i, :));
  endfor
endfunction