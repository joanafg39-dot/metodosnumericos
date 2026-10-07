# Práctica 2 · Raíces de ecuaciones no lineales

**UEA 1151039 · Métodos Numéricos en Ingeniería · Trimestre 26-O · UAM Azcapotzalco**
**Profesor:** M. en C. Gabriel Hurtado Avilés

| | |
|---|---|
| Equipo | |
| Integrantes (nombre, matrícula y licenciatura) | |
| Ecuación asignada | Número y problema |
| Fecha | |

---

## 1. Octave y Python con el paracaidista

Capturas de `octave raices.m` y de `python3 raices.py` sin cambiar nada. Sus tablas
coinciden con las de las láminas de la unidad II.

![Octave](img/01-octave.png)
![Python](img/02-python.png)

## 2. Las cinco líneas que completamos en `raices.c`

```c
/* COMPLETAR 1 */
/* COMPLETAR 2 */
/* COMPLETAR 3 */
/* COMPLETAR 4 */
/* COMPLETAR 5 */
```

![Compilación](img/03-c-compilacion.png)
![Ejecución en C](img/04-c-ejecucion.png)

¿Coinciden las tablas de C con las de Octave y Python? Sí / No, y en qué.

## 3. Las gráficas de Python

![Función](img/funcion.png)
![Convergencia](img/convergencia.png)

## 4. Nuestra ecuación

| | |
|---|---|
| f(x) | |
| f'(x) | |
| g(x) | |
| Intervalo [a, b] | |
| x₀ y δ | |
| Tolerancia | εa ≤ 0.5 % |

![C con nuestra ecuación](img/05-c-ecuacion.png)
![Python con nuestra ecuación](img/06-python-ecuacion.png)

### Tablas (salida de C)

**Bisección**

| k | a | b | x | f(x) | εa (%) |
|---|---|---|---|---|---|
| 1 | | | | | — |
| 2 | | | | | |

**Falsa posición**

| k | a | b | x | f(x) | εa (%) |
|---|---|---|---|---|---|
| 1 | | | | | — |
| 2 | | | | | |

**Punto fijo**

| k | x | f(x) | εa (%) |
|---|---|---|---|
| 0 | | | — |
| 1 | | | |

**Newton-Raphson**

| k | x | f(x) | εa (%) |
|---|---|---|---|
| 0 | | | — |
| 1 | | | |

**Secante modificada**

| k | x | f(x) | εa (%) |
|---|---|---|---|
| 0 | | | — |
| 1 | | | |

Agreguen las filas que hagan falta.

### Resumen

| Método | Raíz | Iteraciones | εa (%) | f(raíz) | Error verdadero (%) |
|---|---|---|---|---|---|
| Bisección | | | | | |
| Falsa posición | | | | | |
| Punto fijo | | | | | |
| Newton-Raphson | | | | | |
| Secante modificada | | | | | |

Raíz de referencia (SciPy):

### Análisis

¿Qué método necesitó menos iteraciones y cuál más? ¿Por qué los cinco no dan
exactamente el mismo número? ¿Alguno no alcanzó la tolerancia o tardó mucho más que
los otros? ¿Por qué?

## 5. Cada integrante en su computadora

Cada integrante corre `raices.c` con la ecuación del equipo en su propia computadora y sube
su captura con un commit propio (ver `COMO_CORRER.md`, sección 7).

| Integrante | Usuario de GitHub | Captura |
|---|---|---|
| | | `img/07-integrante-apellido.png` |
| | | |
| | | |

![Integrante 1](img/07-integrante-apellido.png)

## Uso de inteligencia artificial

Ninguno / Cuál y para qué.

## Referencias

