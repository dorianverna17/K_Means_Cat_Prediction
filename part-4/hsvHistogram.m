function [sol] = hsvHistogram(path_to_image, count_bins)
  % aici este aceeasi functie ca la taskul 3
  img = imread(path_to_image);
  sol = zeros(1, 3 * count_bins);
  t = linspace(0, 1.01, count_bins + 1);
  t1 = linspace(0, 1.01, count_bins + 1);
  [H S V] = hsv_func_helper(path_to_image, count_bins);
  [a1, b1] = histc(H, t);
  [a2, b2] = histc(S, t1);
  [a3, b3] = histc(V, t1);
  sol = zeros(1, 3 * count_bins); nr = 1;
  for i = 1 : count_bins
    sol(1, i) = sum(a1(i, :));
    sol(1, i + count_bins) = sum(a2(i, :));
    sol(1, i + 2 * count_bins) = sum(a3(i, :));
  endfor
endfunction