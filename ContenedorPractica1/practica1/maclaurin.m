% maclaurin.m — Práctica 1: la serie de Maclaurin de e^x y el criterio de paro, en Octave.
%
% Suma términos de e^x = 1 + x + x^2/2! + x^3/3! + ... hasta que el error relativo
% aproximado llega a la tolerancia del criterio de Scarborough. Es el ciclo de la
% lámina 24 de la unidad I, e imprime la misma tabla que maclaurin.py, maclaurin.c y
% la lámina 25.
%
% UEA 1151039 · Métodos Numéricos en Ingeniería · UAM Azcapotzalco · 26-O
%
% Dentro del contenedor, en la carpeta practica1:
%     octave maclaurin.m
%
% Este programa está completo.

% ============================= DATOS =============================
X = 0.5;        % el punto donde se evalúa e^x
CIFRAS = 3;     % cifras significativas que se piden
NMAX = 30;      % máximo de términos
% =================================================================

es = 0.5 * 10^(2 - CIFRAS);              % criterio de Scarborough, en %
verdadero = exp(X);
aprox = 0.0;  termino = 1.0;  n = 0;

printf('Práctica 1 · Serie de Maclaurin de e^x · Octave\n');
printf('x = %g, %d cifras significativas: es = %g %% (criterio de Scarborough)\n', X, CIFRAS, es);
printf('Valor verdadero: exp(%g) = %.15f\n\n', X, verdadero);
printf('%s\n', 'términos         aproximación        et (%)        ea (%)');

do
  anterior = aprox;
  aprox = aprox + termino;
  n = n + 1;
  termino = termino * X / n;                        % el término siguiente, x^n / n!
  ea = abs((aprox - anterior) / aprox) * 100.0;     % error relativo aproximado, en %
  et = abs((verdadero - aprox) / verdadero) * 100.0;
  if n == 1
    printf('%8d %20.15f %13.6g %13s\n', n, aprox, et, '-');
  else
    printf('%8d %20.15f %13.6g %13.6g\n', n, aprox, et, ea);
  end
until (ea <= es || n >= NMAX)                       % «hasta que», como en la lámina 24

printf('\n');
if ea <= es
  printf('Se alcanzó ea <= es con %d términos.\n', n);
else
  printf('No se alcanzó la tolerancia en %d términos.\n', NMAX);
end
printf('Aproximación: %.15f   error verdadero: %g %%\n', aprox, et);
