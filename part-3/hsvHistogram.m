function [sol] = hsvHistogram(path_to_image, count_bins)
  % aici citesc imaginea
  img = imread(path_to_image);
  % initializez vectorul sol
  % realizarea vectorului care cuprinde intervalele valorilor
  % pixelilor pentru H (care ia valori intre 0 si 360)
  t = linspace(0, 1.01, count_bins + 1);
  % realizarea vectorului care cuprinde intervalele valorilor
  % pixelilor pentru S si V (care iau valori intre 0 si 100)
  t1 = linspace(0, 1.01, count_bins + 1);
  % fomarea functiilor H, S, V
  [H S V] = hsv_func_helper(path_to_image, count_bins);
  % gruparea pixelilor in functie de intervalul din care fac parte
  [a1, b1] = histc(H, t);
  [a2, b2] = histc(S, t1);
  [a3, b3] = histc(V, t1);
  % initializarea vectorului sol
  sol = zeros(1, 3 * count_bins);
  % formarea vectorului sol
  for i = 1 : count_bins
    sol(1, i) = sum(a1(i, :));
    sol(1, i + count_bins) = sum(a2(i, :));
    sol(1, i + 2 * count_bins) = sum(a3(i, :));
  endfor
endfunction