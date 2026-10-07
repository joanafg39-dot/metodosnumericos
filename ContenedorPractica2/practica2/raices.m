% raices.m — Práctica 2: raíces de ecuaciones no lineales, en Octave.
%
% Los cinco métodos de la unidad II sobre la misma ecuación. Imprime una
% tabla por método y un resumen; las tablas deben coincidir, cifra por cifra,
% con las de raices.c, raices.py y las de las láminas.
%
% UEA 1151039 · Métodos Numéricos en Ingeniería · UAM Azcapotzalco · 26-O
%
% Dentro del contenedor, en la carpeta practica2:
%     octave raices.m
%
% Este programa está completo. Es el modelo para completar raices.c.

1;   % le dice a Octave que este archivo es un guion y no una sola función

% ======================== BLOQUE DEL PROBLEMA ========================
% Es lo único que se cambia para resolver otra ecuación (ejercicio 4).

function txt = descripcion()
  txt = 'f(c) = g m / c (1 - exp(-c t / m)) - v,  g = 9.8, m = 68.1, t = 10, v = 40';
end

function txt = descr_g()
  txt = 'g(c) = g m / v (1 - exp(-c t / m))';
end

function [GRAV, MASA, TIEMPO, VEL] = constantes()
  GRAV   = 9.8;     % gravedad, m/s^2
  MASA   = 68.1;    % masa del paracaidista, kg
  TIEMPO = 10.0;    % tiempo de caída, s
  VEL    = 40.0;    % velocidad medida, m/s
end

% La función cuya raíz se busca: el coeficiente de arrastre c, en kg/s.
function y = f(c)
  [GRAV, MASA, TIEMPO, VEL] = constantes();
  y = GRAV * MASA / c * (1.0 - exp(-c * TIEMPO / MASA)) - VEL;
end

% Su derivada, para Newton-Raphson.
function y = fp(c)
  [GRAV, MASA, TIEMPO, VEL] = constantes();
  y = GRAV * MASA / c * (TIEMPO / MASA) * exp(-c * TIEMPO / MASA) ...
    - GRAV * MASA / (c * c) * (1.0 - exp(-c * TIEMPO / MASA));
end

% Despeje x = g(x) para punto fijo: c = g m / v (1 - exp(-c t / m)).
function y = g(c)
  [GRAV, MASA, TIEMPO, VEL] = constantes();
  y = GRAV * MASA / VEL * (1.0 - exp(-c * TIEMPO / MASA));
end

% =====================================================================

function txt = enc_cerrado()
  txt = '   k             a             b             x            f(x)     ea (%)';
end

function txt = enc_abierto()
  txt = '   k             x            f(x)     ea (%)';
end

% Error relativo aproximado, en porcentaje: |(nuevo - anterior) / nuevo| · 100.
function e = error_aprox(nuevo, anterior)
  e = abs((nuevo - anterior) / nuevo) * 100.0;
end

function fila_cerrado(k, a, b, x, ea, con_ea)
  printf('%4d %13.6f %13.6f %13.6f %15.6e ', k, a, b, x, f(x));
  if con_ea
    printf('%10.4f\n', ea);
  else
    printf('%10s\n', '-');
  end
end

function fila_abierto(k, x, ea, con_ea)
  printf('%4d %13.6f %15.6e ', k, x, f(x));
  if con_ea
    printf('%10.4f\n', ea);
  else
    printf('%10s\n', '-');
  end
end

function cierre(r, nmax)
  if r.ok
    printf('   Raíz aproximada: %.6f  (%d iteraciones, ea = %.4f %%)\n', r.x, r.k, r.ea);
  else
    printf('   No alcanzó la tolerancia en %d iteraciones.\n', nmax);
  end
  printf('\n');
end

% Bisección: parte el intervalo a la mitad y conserva la mitad con cambio de signo.
function r = biseccion(a, b, tol, nmax)
  r = struct('x', 0, 'ea', 0, 'k', 0, 'ok', false);
  x_ant = 0.0;  ea = 0.0;
  printf('1. Bisección en [%g, %g]\n', a, b);
  printf('%s\n', enc_cerrado());
  for k = 1:nmax
    x = (a + b) / 2.0;                       % punto medio
    if k > 1
      ea = error_aprox(x, x_ant);
    end
    fila_cerrado(k, a, b, x, ea, k > 1);
    r.x = x;  r.ea = ea;  r.k = k;
    if k > 1 && ea <= tol
      r.ok = true;
      break;
    end
    if f(a) * f(x) < 0.0
      b = x;                                 % la raíz está en [a, x]
    else
      a = x;                                 % la raíz está en [x, b]
    end
    x_ant = x;
  end
  cierre(r, nmax);
end

% Falsa posición: corta la recta que une (a, f(a)) y (b, f(b)) con el eje x.
function r = falsa_posicion(a, b, tol, nmax)
  r = struct('x', 0, 'ea', 0, 'k', 0, 'ok', false);
  x_ant = 0.0;  ea = 0.0;
  printf('2. Falsa posición en [%g, %g]\n', a, b);
  printf('%s\n', enc_cerrado());
  for k = 1:nmax
    x = b - f(b) * (a - b) / (f(a) - f(b));  % cero de la recta
    if k > 1
      ea = error_aprox(x, x_ant);
    end
    fila_cerrado(k, a, b, x, ea, k > 1);
    r.x = x;  r.ea = ea;  r.k = k;
    if k > 1 && ea <= tol
      r.ok = true;
      break;
    end
    if f(a) * f(x) < 0.0
      b = x;
    else
      a = x;
    end
    x_ant = x;
  end
  cierre(r, nmax);
end

% Punto fijo: repite x <- g(x).
function r = punto_fijo(x, tol, nmax)
  r = struct('x', x, 'ea', 0, 'k', 0, 'ok', false);
  printf('3. Punto fijo desde x0 = %g, con %s\n', x, descr_g());
  printf('%s\n', enc_abierto());
  fila_abierto(0, x, 0.0, false);
  for k = 1:nmax
    x_nuevo = g(x);
    ea = error_aprox(x_nuevo, x);
    x = x_nuevo;
    fila_abierto(k, x, ea, true);
    r.x = x;  r.ea = ea;  r.k = k;
    if ea <= tol
      r.ok = true;
      break;
    end
  end
  cierre(r, nmax);
end

% Newton-Raphson: el cero de la recta tangente en x.
function r = newton(x, tol, nmax)
  r = struct('x', x, 'ea', 0, 'k', 0, 'ok', false);
  printf('4. Newton-Raphson desde x0 = %g\n', x);
  printf('%s\n', enc_abierto());
  fila_abierto(0, x, 0.0, false);
  for k = 1:nmax
    x_nuevo = x - f(x) / fp(x);
    ea = error_aprox(x_nuevo, x);
    x = x_nuevo;
    fila_abierto(k, x, ea, true);
    r.x = x;  r.ea = ea;  r.k = k;
    if ea <= tol
      r.ok = true;
      break;
    end
  end
  cierre(r, nmax);
end

% Secante modificada: Newton con la derivada aproximada por una diferencia.
function r = secante_modificada(x, delta, tol, nmax)
  r = struct('x', x, 'ea', 0, 'k', 0, 'ok', false);
  printf('5. Secante modificada desde x0 = %g, delta = %g\n', x, delta);
  printf('%s\n', enc_abierto());
  fila_abierto(0, x, 0.0, false);
  for k = 1:nmax
    x_nuevo = x - delta * f(x) / (f(x + delta) - f(x));
    ea = error_aprox(x_nuevo, x);
    x = x_nuevo;
    fila_abierto(k, x, ea, true);
    r.x = x;  r.ea = ea;  r.k = k;
    if ea <= tol
      r.ok = true;
      break;
    end
  end
  cierre(r, nmax);
end

% ============================ PROGRAMA ============================

A = 12.0;  B = 16.0;   % intervalo de los métodos cerrados
X0 = 12.5;             % inicio de los métodos abiertos
DELTA = 0.05;          % incremento de la secante modificada
TOL = 0.5;             % tolerancia: ea en %
NMAX = 50;             % máximo de iteraciones

printf('Práctica 2 · Raíces de ecuaciones no lineales · Octave\n');
printf('%s\n', descripcion());
printf('Tolerancia: ea <= %g %%, máximo %d iteraciones\n\n', TOL, NMAX);

r(1) = biseccion(A, B, TOL, NMAX);
r(2) = falsa_posicion(A, B, TOL, NMAX);
r(3) = punto_fijo(X0, TOL, NMAX);
r(4) = newton(X0, TOL, NMAX);
r(5) = secante_modificada(X0, DELTA, TOL, NMAX);

nombres = {'Bisección', 'Falsa posición', 'Punto fijo', 'Newton-Raphson', 'Secante modificada'};
printf('Resumen\n');
printf('            x  iter.     ea (%%)            f(x)   método\n');
for i = 1:5
  aviso = '';
  if ~r(i).ok
    aviso = ' (no convergió)';
  end
  printf('%13.6f %6d %10.4f %15.6e   %s%s\n', r(i).x, r(i).k, r(i).ea, f(r(i).x), nombres{i}, aviso);
end
