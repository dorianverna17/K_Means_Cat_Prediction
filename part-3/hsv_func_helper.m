function [H S V] = hsv_func_helper(path_to_image, count_bins)
  % functie care implementeaza prin vectorizare
  % realizarea transformarii RGB-HSV
  % formez matricele de pixeli R G B
  img = imread(path_to_image);
  t = linspace(0, 256, count_bins + 1);
  [R] = histc(img(:, :, 1), t);
  [G] = histc(img(:, :, 2), t);
  [B] = histc(img(:, :, 3), t);
  [n m] = size(R);
  % aplic algoritmul dat in pdf-ul de la tema
  R1 = double(img(:, :, 1)) / 255;
  G1 = double(img(:, :, 2)) / 255;
  B1 = double(img(:, :, 3)) / 255;
  [n m] = size(R1);
  % calculez Cmax si Cmin, iar apoi delta
  Cmax = zeros(n, m); Cmin = zeros(n, m);
  Cmax1 = max(R1, G1);
  Cmax = max(Cmax1, B1);
  Cmin1 = min(R1, G1);
  Cmin = min(Cmin1, B1);
  delta = Cmax - Cmin;
  H = zeros(n, m); S = H; V = H;
  % Aici am ales sa fac prin vectorizare
  H(delta == 0) = 0;
  H(result = Cmax == R1) = 60 * (mod(double((G1(result = Cmax == R1)...
  - B1(result = Cmax == R1)) ./ delta(result = Cmax == R1)), 6));
  H(result = Cmax == G1) = 60 * ((double((B1(result = Cmax == G1)...
  - R1(result = Cmax == G1)) ./ delta(result = Cmax == G1)) + 2));
  H(result = Cmax == B1) = 60 * ((double((R1(result = Cmax == B1)...
  - G1(result = Cmax == B1)) ./ delta(result = Cmax == B1)) + 4));
  % acum normez H si formez si S si V
  H = double(H) / 360;
  S(result = Cmax == 0) = 0;
  S(result = Cmax != 0) = double(delta(result = Cmax != 0)...
  ./ Cmax(result = Cmax != 0));
  V = Cmax;
endfunction