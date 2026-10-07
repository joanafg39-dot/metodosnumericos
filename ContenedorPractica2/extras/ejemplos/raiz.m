% raiz.m — √2 por el método babilónico, en Octave.
% Es el ejemplo de apertura del curso: sólo usa suma y división.
% UEA 1151039 · Métodos Numéricos en Ingeniería · UAM Azcapotzalco

x = 1.0;                      % conjetura inicial
for k = 1:4
  x = 0.5 * (x + 2.0 / x);    % la misma regla, repetida
end
printf('%.12f\n', x);
