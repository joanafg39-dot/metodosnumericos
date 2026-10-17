# Cómo correr los programas de la Práctica 2

**UEA 1151039 · Métodos Numéricos en Ingeniería · 26-O · UAM Azcapotzalco**

Los tres programas resuelven la misma ecuación con los mismos cinco métodos y deben
imprimir **exactamente las mismas tablas**. Se corren uno por uno, dentro del contenedor.

| Archivo | Cómo viene | Qué te toca |
|---|---|---|
| `raices.m` | Completo | Correrlo y comparar con las láminas |
| `raices.py` | Completo, salvo las gráficas | Completar `graficar()` |
| `raices.c` | Le faltan cinco líneas: `COMPLETAR 1` a `COMPLETAR 5` | Completarlas, compilar y correr |

---

## 1 · Prender el contenedor y entrar

En la terminal de Windows, **en la raíz del repositorio del equipo**, donde está
`compose.yaml` desde la Práctica 1:

```bash
docker compose up -d
docker compose exec metodos bash
```

El prompt cambia a `root@...:/trabajo#`. Ya estás dentro. Ahora entra a la carpeta de
la práctica:

```bash
cd practica2
ls
```

Debe listar `raices.c  raices.m  raices.py` y los dos `.md`.

---

## 2 · Octave

```bash
octave raices.m
```

## 3 · Python

```bash
python3 raices.py
```

Al final dice `graficar(): falta completar`. Es normal hasta que completes esa función;
después dirá `Figuras guardadas en img/funcion.png y img/convergencia.png`.

## 4 · C: dos pasos, compilar y ejecutar

```bash
gcc -O2 -std=c17 -Wall -o raices raices.c -lm
./raices
```

El primero crea el ejecutable `raices`; el segundo lo corre. **Cada vez que cambies
`raices.c` hay que volver a compilar.**

Mientras falten las cinco líneas, el programa compila y corre, pero las tablas salen con
`nan`, `inf` o «No alcanzó la tolerancia». Eso quiere decir que falta completar, no que el
entorno esté mal. gcc avisa además `'fp' defined but not used` y `'g' defined but not
used`: es una pista de qué funciones todavía no usa tu código, no un error.

---

## 5 · Qué debe salir

Las tres salidas empiezan igual, salvo el nombre del lenguaje en la primera línea. La
primera tabla, la de bisección, es ésta:

```
1. Bisección en [12, 16]
   k             a             b             x            f(x)     ea (%)
   1     12.000000     16.000000     14.000000    1.568699e+00          -
   2     14.000000     16.000000     15.000000   -4.248409e-01     6.6667
   3     14.000000     15.000000     14.500000    5.523185e-01     3.4483
   4     14.500000     15.000000     14.750000    5.895351e-02     1.6949
   5     14.750000     15.000000     14.875000   -1.841257e-01     0.8403
   6     14.750000     14.875000     14.812500   -6.288337e-02     0.4219
   Raíz aproximada: 14.812500  (6 iteraciones, ea = 0.4219 %)
```

Las otras cuatro tablas y el resumen están en las láminas de la unidad II. Si una sola
cifra es distinta, algo está mal.

> **Para guardar una salida en un archivo** y copiarla al reporte:
> `./raices > salida_c.txt`. Igual con `octave raices.m > salida_octave.txt`.

---

## 6 · Para resolver la ecuación de tu equipo

Las 30 ecuaciones están en [`ECUACIONES.md`](ECUACIONES.md), tres por licenciatura.
Busca la que el profesor le asignó a tu equipo: ahí vienen el problema, sus datos y el
**bloque del problema** listo para copiar en `raices.c` y en `raices.py`.

En cada uno de los dos programas, sustituye desde la línea `BLOQUE DEL PROBLEMA` hasta la
línea de `=====` que la cierra (las dos incluidas) por el bloque de tu ecuación. Ahí están
la función `f`, su derivada `fp`, el despeje `g`, las constantes, el intervalo `A` y `B`,
el inicio `X0` y el incremento `DELTA`. El resto del programa no se toca. Después compila
y corre igual que con el paracaidista. `raices.m` se queda con el paracaidista.

Si copias el bloque completo, tus tablas coinciden cifra por cifra con las del profesor.
Si lo escribes tú, usa `x` como nombre de la variable: en Octave, `i` y `e` ya significan
otra cosa (la unidad imaginaria y el número e).

---

## 7 · Tu captura, en tu computadora

Cuando la ecuación del equipo ya corre, **cada integrante** repite la ejecución en su propia
computadora y sube su captura con un commit propio. Así se comprueba que el entorno funciona
en todas las máquinas del equipo y queda constancia de quién participó.

En la terminal de Windows, en la raíz del repositorio del equipo:

```bash
git switch practica2
git pull
docker compose up -d
docker compose exec metodos bash
```

Ya dentro del contenedor:

```bash
cd practica2
gcc -O2 -std=c17 -Wall -o raices raices.c -lm && ./raices
exit
```

Toma la captura de la terminal (en Windows, `Win + Shift + S`) y guárdala en
`practica2/img/` con el nombre `07-integrante-tuapellido.png`, sin acentos ni espacios.
Agrégala a la sección 5 del README y, de vuelta en Windows:

```bash
git add practica2/img/07-integrante-tuapellido.png practica2/README.md
git commit -m "Captura de Nombre Apellido en su computadora"
git push
```

Si `git push` responde que la rama cambió, primero `git pull` y después otra vez `git push`.

---

## 😰 Si algo salió mal

| Salió esto | Es que… | Haz esto |
|---|---|---|
| `octave: command not found` o `gcc: command not found` | Estás en Windows, fuera del contenedor | `docker compose exec metodos bash` |
| `No such file or directory` | No estás en la carpeta de la práctica | `cd /trabajo/practica2` |
| `undefined reference to 'exp'` | Te faltó `-lm` al final de `gcc` | Copia el comando completo |
| `ModuleNotFoundError: No module named 'scipy'` | Corriste Python de Windows | Entra al contenedor primero |
| La tabla de C sale con `nan` o `inf` | Faltan líneas `COMPLETAR` | Revisa la que corresponde a ese método |
| Todos los métodos «convergen» en la iteración 2 | `error_aprox` devuelve 0 | Es la línea `COMPLETAR 1` |
| Cambiaste `raices.c` y la salida no cambia | No volviste a compilar | `gcc ...` y después `./raices` |
