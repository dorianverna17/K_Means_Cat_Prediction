function [sol] = rgbHistogram(path_to_image, count_bins)
  % citirea imaginii
  img = imread(path_to_image);
  % realizarea vectorului care cuprinde intervalele valorilor pixelilor
  t = linspace(0, 256, count_bins + 1);
  % gruparea pixelilor culorii rosii in functie de
  % intervalul din care fac parte
  [a1, b1] = histc(img(:, :, 1), t);
  % gruparea pixelilor culorii verzi in functie de
  % intervalul din care fac parte
  [a2, b2] = histc(img(:, :, 2), t);
  % gruparea pixelilor culorii albastre in functie de
  % intervalul din care fac parte
  [a3, b3] = histc(img(:, :, 3), t);
  % initializarea vectorului de caracterisitici RGB
  sol = zeros(1, 3 * count_bins); nr = 1; 
  % in acest for se formeaza acest vector
  for i = 1 : count_bins
    sol(1, i) = sum(a1(i, :));
    sol(1, i + count_bins) = sum(a2(i, :));
    sol(1, i + 2 * count_bins) = sum(a3(i, :));
  endfor
endfunction