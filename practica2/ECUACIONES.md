# Práctica 2 · Las ecuaciones de cada equipo

**UEA 1151039 · Métodos Numéricos en Ingeniería · 26-O · UAM Azcapotzalco**

Hay 30 ecuaciones, tres por licenciatura. El profesor le asigna a cada equipo una, de la licenciatura de alguno de sus integrantes, y dos equipos no repiten ecuación.

Para resolver la suya, en `raices.c` y en `raices.py` sustituyan desde la línea `BLOQUE DEL PROBLEMA` hasta la línea de `=====` que la cierra (las dos incluidas) por el bloque de su ecuación, que viene abajo. Compilen y corran igual que con el paracaidista. Si copian el bloque completo, sus tablas coinciden cifra por cifra con las del profesor.

En todas: tolerancia εa ≤ 0.5 % y máximo 50 iteraciones. En algunas, un método tarda mucho o no alcanza la tolerancia; no es un error de su programa, y el análisis tiene que explicar por qué.

| Licenciatura | Ecuaciones |
|---|---|
| Ambiental | [1. Tanque esférico](#e01) · [2. Oxígeno disuelto en un río](#e02) · [3. Sedimentación de arena](#e03) |
| Civil | [4. Deflexión de una viga](#e04) · [5. Fricción en tuberías (Colebrook)](#e05) · [6. Tirante crítico de un canal](#e06) |
| Computación | [7. Algoritmo n log n](#e07) · [8. Trazado de rayos](#e08) · [9. Entropía de un canal binario](#e09) |
| Eléctrica | [10. Circuito RLC](#e10) · [11. Generador síncrono](#e11) · [12. Catenaria de una línea aérea](#e12) |
| Electrónica | [13. Diodo con resistencia](#e13) · [14. Rectificador con carga RL](#e14) · [15. Termistor NTC](#e15) |
| Física | [16. Ecuación de Kepler](#e16) · [17. Ley de Wien](#e17) · [18. Punto de Lagrange L1](#e18) |
| Industrial | [19. Tasa interna de retorno](#e19) · [20. Confiabilidad en paralelo](#e20) · [21. Reemplazo de equipo](#e21) |
| Mecánica | [22. Mecanismo de cuatro barras](#e22) · [23. Vibración de un voladizo](#e23) · [24. Columna excéntrica](#e24) |
| Metalúrgica | [25. Placa en un horno](#e25) · [26. Ebullición del zinc](#e26) · [27. Temple de una placa](#e27) |
| Química | [28. Van der Waals (CO₂)](#e28) · [29. Equilibrio químico](#e29) · [30. Punto de burbuja](#e30) |

---

## Ambiental

<a id="e01"></a>

### 1 · Nivel de agua en un tanque esférico, R = 3 m, V = 30 m³

Un tanque esférico de 3 m de radio guarda el agua de una comunidad. ¿A qué altura h (m) llega el agua cuando contiene 30 m³? El volumen de un casquete esférico de altura h es πh²(3R − h)/3.

| | |
|---|---|
| f(x) | f(h) = π h² (3R − h) / 3 − V |
| Despeje para punto fijo | g(h) = √((h³ + 3V/π) / (3R)) |
| Intervalo [a, b] | [0.5, 3] |
| x₀ y δ | x₀ = 2 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 1 · Ambiental · Nivel de agua en un tanque esférico, R = 3 m, V = 30 m³ */

#define DESCRIPCION "f(h) = pi h^2 (3R - h) / 3 - V,  R = 3, V = 30"
#define DESCR_G     "g(h) = sqrt((h^3 + 3V/pi) / (3R))"

static const double RAD = 3.0;   /* radio del tanque, m */
static const double VOL = 30.0;   /* volumen, m^3 */
static const double PI = 3.141592653589793;

static const double A = 0.5, B = 3.0;  /* intervalo de los métodos cerrados */
static const double X0    = 2.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return PI*x*x*(3*RAD - x)/3 - VOL;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return PI*(6*RAD*x - 3*x*x)/3;
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return sqrt((x*x*x + 3*VOL/PI) / (3*RAD));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 1 · Ambiental · Nivel de agua en un tanque esférico, R = 3 m, V = 30 m³

DESCRIPCION = 'f(h) = pi h^2 (3R - h) / 3 - V,  R = 3, V = 30'
DESCR_G = 'g(h) = sqrt((h^3 + 3V/pi) / (3R))'

RAD = 3.0   # radio del tanque, m
VOL = 30.0   # volumen, m^3

A, B = 0.5, 3.0   # intervalo de los métodos cerrados
X0 = 2.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return math.pi*x*x*(3*RAD - x)/3 - VOL


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return math.pi*(6*RAD*x - 3*x*x)/3


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return math.sqrt((x*x*x + 3*VOL/math.pi) / (3*RAD))

# =====================================================================
```

</details>

<a id="e02"></a>

### 2 · Distancia a la que el oxígeno disuelto de un río baja a 5 mg/L

Aguas abajo de una descarga de agua residual, el oxígeno disuelto de un río sigue c(x) = 10 − 20 (e^(−0.15x) − e^(−0.5x)) mg/L, con x en km. ¿A qué distancia baja por primera vez a 5 mg/L, el mínimo para la vida acuática?

| | |
|---|---|
| f(x) | f(x) = 10 − 20 (e^(−0.15x) − e^(−0.5x)) − 5 |
| Despeje para punto fijo | g(x) = −ln(e^(−0.15x) − 0.25) / 0.5 |
| Intervalo [a, b] | [0, 3] |
| x₀ y δ | x₀ = 0.5 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 2 · Ambiental · Distancia a la que el oxígeno disuelto de un río baja a 5 mg/L */

#define DESCRIPCION "f(x) = 10 - 20 (exp(-0.15 x) - exp(-0.5 x)) - 5"
#define DESCR_G     "g(x) = -ln(exp(-0.15 x) - 0.25) / 0.5"

static const double OSAT = 10.0;   /* oxígeno en la descarga, mg/L */
static const double DEF = 20.0;   /* amplitud del déficit, mg/L */
static const double KD = 0.15;   /* desoxigenación, 1/km */
static const double KA = 0.5;   /* reaireación, 1/km */
static const double COBJ = 5.0;   /* oxígeno mínimo, mg/L */

static const double A = 0.0, B = 3.0;  /* intervalo de los métodos cerrados */
static const double X0    = 0.5;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return OSAT - DEF*(exp(-KD*x) - exp(-KA*x)) - COBJ;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return -DEF*(KA*exp(-KA*x) - KD*exp(-KD*x));
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return -log(exp(-KD*x) - (OSAT - COBJ)/DEF)/KA;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 2 · Ambiental · Distancia a la que el oxígeno disuelto de un río baja a 5 mg/L

DESCRIPCION = 'f(x) = 10 - 20 (exp(-0.15 x) - exp(-0.5 x)) - 5'
DESCR_G = 'g(x) = -ln(exp(-0.15 x) - 0.25) / 0.5'

OSAT = 10.0   # oxígeno en la descarga, mg/L
DEF = 20.0   # amplitud del déficit, mg/L
KD = 0.15   # desoxigenación, 1/km
KA = 0.5   # reaireación, 1/km
COBJ = 5.0   # oxígeno mínimo, mg/L

A, B = 0.0, 3.0   # intervalo de los métodos cerrados
X0 = 0.5         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return OSAT - DEF*(math.exp(-KD*x) - math.exp(-KA*x)) - COBJ


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return -DEF*(KA*math.exp(-KA*x) - KD*math.exp(-KD*x))


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return -math.log(math.exp(-KD*x) - (OSAT - COBJ)/DEF)/KA

# =====================================================================
```

</details>

<a id="e03"></a>

### 3 · Velocidad de sedimentación de un grano de arena de 0.5 mm

En un desarenador, un grano de arena (ρp = 2650 kg/m³, d = 0.5 mm) cae en agua (ρ = 1000 kg/m³, μ = 0.001 Pa·s). Su velocidad terminal v (m/s) equilibra peso y arrastre: v² C_D = 4g(ρp − ρ)d/(3ρ), con C_D = 24/Re + 3/√Re + 0.34 y Re = ρvd/μ.

| | |
|---|---|
| f(x) | f(v) = v² C_D(v) − 4g(ρp − ρ)d / (3ρ),  C_D = 24/Re + 3/√Re + 0.34,  Re = ρvd/μ |
| Despeje para punto fijo | g(v) = √(4g(ρp − ρ)d / (3ρ C_D(v))) |
| Intervalo [a, b] | [0.01, 0.3] |
| x₀ y δ | x₀ = 0.05 · δ = 0.001 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 3 · Ambiental · Velocidad de sedimentación de un grano de arena de 0.5 mm */

#define DESCRIPCION "f(v) = v^2 CD(v) - 4 g (rp - r) d / (3 r),  CD = 24/Re + 3/sqrt(Re) + 0.34"
#define DESCR_G     "g(v) = sqrt(4 g (rp - r) d / (3 r CD(v)))"

static const double GRAV = 9.81;   /* gravedad, m/s^2 */
static const double RHOP = 2650.0;   /* densidad de la arena, kg/m^3 */
static const double RHOW = 1000.0;   /* densidad del agua, kg/m^3 */
static const double DIAM = 0.0005;   /* diámetro del grano, m */
static const double VISC = 0.001;   /* viscosidad del agua, Pa s */

static const double A = 0.01, B = 0.3;  /* intervalo de los métodos cerrados */
static const double X0    = 0.05;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.001;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return 24*VISC*x/(RHOW*DIAM) + 3*x*sqrt(x*VISC/(RHOW*DIAM)) + 0.34*x*x - 4*GRAV*(RHOP - RHOW)*DIAM/(3*RHOW);
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return 24*VISC/(RHOW*DIAM) + 4.5*sqrt(x*VISC/(RHOW*DIAM)) + 0.68*x;
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return sqrt(4*GRAV*(RHOP - RHOW)*DIAM/(3*RHOW) / (24*VISC/(RHOW*DIAM*x) + 3*sqrt(VISC/(RHOW*DIAM*x)) + 0.34));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 3 · Ambiental · Velocidad de sedimentación de un grano de arena de 0.5 mm

DESCRIPCION = 'f(v) = v^2 CD(v) - 4 g (rp - r) d / (3 r),  CD = 24/Re + 3/sqrt(Re) + 0.34'
DESCR_G = 'g(v) = sqrt(4 g (rp - r) d / (3 r CD(v)))'

GRAV = 9.81   # gravedad, m/s^2
RHOP = 2650.0   # densidad de la arena, kg/m^3
RHOW = 1000.0   # densidad del agua, kg/m^3
DIAM = 0.0005   # diámetro del grano, m
VISC = 0.001   # viscosidad del agua, Pa s

A, B = 0.01, 0.3   # intervalo de los métodos cerrados
X0 = 0.05         # inicio de los métodos abiertos
DELTA = 0.001      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return 24*VISC*x/(RHOW*DIAM) + 3*x*math.sqrt(x*VISC/(RHOW*DIAM)) + 0.34*x*x - 4*GRAV*(RHOP - RHOW)*DIAM/(3*RHOW)


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return 24*VISC/(RHOW*DIAM) + 4.5*math.sqrt(x*VISC/(RHOW*DIAM)) + 0.68*x


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return math.sqrt(4*GRAV*(RHOP - RHOW)*DIAM/(3*RHOW) / (24*VISC/(RHOW*DIAM*x) + 3*math.sqrt(VISC/(RHOW*DIAM*x)) + 0.34))

# =====================================================================
```

</details>

---

## Civil

<a id="e04"></a>

### 4 · Deflexión máxima de una viga, L = 600 cm

La elástica de una viga simplemente apoyada con carga triangular es y = w₀(−x⁵ + 2L²x³ − L⁴x)/(120EIL). La deflexión máxima está donde dy/dx = 0. ¿En qué punto x (cm) de una viga de 600 cm?

| | |
|---|---|
| f(x) | f(x) = −5x⁴ + 6L²x² − L⁴ |
| Despeje para punto fijo | g(x) = √((5x⁴ + L⁴) / (6L²)) |
| Intervalo [a, b] | [0, 400] |
| x₀ y δ | x₀ = 200 · δ = 0.05 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 4 · Civil · Deflexión máxima de una viga, L = 600 cm */

#define DESCRIPCION "f(x) = -5 x^4 + 6 L^2 x^2 - L^4,  L = 600"
#define DESCR_G     "g(x) = sqrt((5 x^4 + L^4) / (6 L^2))"

static const double LONG = 600.0;   /* longitud de la viga, cm */

static const double A = 0.0, B = 400.0;  /* intervalo de los métodos cerrados */
static const double X0    = 200.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.05;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return -5*x*x*x*x + 6*LONG*LONG*x*x - LONG*LONG*LONG*LONG;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return -20*x*x*x + 12*LONG*LONG*x;
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return sqrt((5*x*x*x*x + LONG*LONG*LONG*LONG) / (6*LONG*LONG));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 4 · Civil · Deflexión máxima de una viga, L = 600 cm

DESCRIPCION = 'f(x) = -5 x^4 + 6 L^2 x^2 - L^4,  L = 600'
DESCR_G = 'g(x) = sqrt((5 x^4 + L^4) / (6 L^2))'

LONG = 600.0   # longitud de la viga, cm

A, B = 0.0, 400.0   # intervalo de los métodos cerrados
X0 = 200.0         # inicio de los métodos abiertos
DELTA = 0.05      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return -5*x*x*x*x + 6*LONG*LONG*x*x - LONG*LONG*LONG*LONG


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return -20*x*x*x + 12*LONG*LONG*x


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return math.sqrt((5*x*x*x*x + LONG*LONG*LONG*LONG) / (6*LONG*LONG))

# =====================================================================
```

</details>

<a id="e05"></a>

### 5 · Factor de fricción de una tubería (Colebrook), Re = 10⁵, ε/D = 0.0002

Para dimensionar una tubería de agua potable hace falta el factor de fricción de Darcy, x, que cumple la ecuación de Colebrook. Tubería de concreto liso (rugosidad relativa ε/D = 0.0002) con flujo turbulento, Re = 10⁵.

| | |
|---|---|
| f(x) | f(x) = 1/√x + 2 log₁₀(0.0002/3.7 + 2.51/(10⁵ √x)) |
| Despeje para punto fijo | g(x) = 1 / (2 log₁₀(0.0002/3.7 + 2.51/(10⁵ √x)))² |
| Intervalo [a, b] | [0.008, 0.08] |
| x₀ y δ | x₀ = 0.02 · δ = 0.00001 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 5 · Civil · Factor de fricción de una tubería (Colebrook), Re = 10⁵, ε/D = 0.0002 */

#define DESCRIPCION "f(x) = 1/sqrt(x) + 2 log10(0.0002/3.7 + 2.51/(1e5 sqrt(x)))"
#define DESCR_G     "g(x) = 1 / (2 log10(0.0002/3.7 + 2.51/(1e5 sqrt(x))))^2"

static const double RE = 100000.0;   /* número de Reynolds */
static const double RUG = 0.0002;   /* rugosidad relativa e/D */

static const double A = 0.008, B = 0.08;  /* intervalo de los métodos cerrados */
static const double X0    = 0.02;        /* inicio de los métodos abiertos    */
static const double DELTA = 1e-05;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return 1/sqrt(x) + 2*log10(RUG/3.7 + 2.51/(RE*sqrt(x)));
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return -0.5/(x*sqrt(x)) + 2/log(10) / (RUG/3.7 + 2.51/(RE*sqrt(x))) * (-0.5*2.51/RE/(x*sqrt(x)));
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return 1/((2*log10(RUG/3.7 + 2.51/(RE*sqrt(x)))) * (2*log10(RUG/3.7 + 2.51/(RE*sqrt(x)))));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 5 · Civil · Factor de fricción de una tubería (Colebrook), Re = 10⁵, ε/D = 0.0002

DESCRIPCION = 'f(x) = 1/sqrt(x) + 2 log10(0.0002/3.7 + 2.51/(1e5 sqrt(x)))'
DESCR_G = 'g(x) = 1 / (2 log10(0.0002/3.7 + 2.51/(1e5 sqrt(x))))^2'

RE = 100000.0   # número de Reynolds
RUG = 0.0002   # rugosidad relativa e/D

A, B = 0.008, 0.08   # intervalo de los métodos cerrados
X0 = 0.02         # inicio de los métodos abiertos
DELTA = 1e-05      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return 1/math.sqrt(x) + 2*math.log10(RUG/3.7 + 2.51/(RE*math.sqrt(x)))


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return -0.5/(x*math.sqrt(x)) + 2/math.log(10) / (RUG/3.7 + 2.51/(RE*math.sqrt(x))) * (-0.5*2.51/RE/(x*math.sqrt(x)))


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return 1/((2*math.log10(RUG/3.7 + 2.51/(RE*math.sqrt(x)))) * (2*math.log10(RUG/3.7 + 2.51/(RE*math.sqrt(x)))))

# =====================================================================
```

</details>

<a id="e06"></a>

### 6 · Tirante crítico en un canal trapezoidal, Q = 20 m³/s

Un canal trapezoidal de 3 m de plantilla y taludes 0.5:1 lleva Q = 20 m³/s. El tirante crítico y (m) cumple Q²B/(gA³) = 1, con A = 3y + y²/2 el área hidráulica y B = 3 + y el ancho de la superficie libre.

| | |
|---|---|
| f(x) | f(y) = 1 − Q²B / (gA³),  A = 3y + y²/2,  B = 3 + y |
| Despeje para punto fijo | g(y) = √(Q²(3 + y) / (g y (3 + y/2)³)) |
| Intervalo [a, b] | [0.5, 2.5] |
| x₀ y δ | x₀ = 1 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 6 · Civil · Tirante crítico en un canal trapezoidal, Q = 20 m³/s */

#define DESCRIPCION "f(y) = 1 - Q^2 B / (g A^3),  A = 3y + y^2/2,  B = 3 + y,  Q = 20"
#define DESCR_G     "g(y) = sqrt(Q^2 (3 + y) / (g y (3 + y/2)^3))"

static const double CAUDAL = 20.0;   /* gasto, m^3/s */
static const double GRAV = 9.81;   /* gravedad, m/s^2 */

static const double A = 0.5, B = 2.5;  /* intervalo de los métodos cerrados */
static const double X0    = 1.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return 1 - CAUDAL*CAUDAL*(3 + x)/(GRAV*(3*x + x*x/2)*(3*x + x*x/2)*(3*x + x*x/2));
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return -CAUDAL*CAUDAL/GRAV*(1/((3*x + x*x/2)*(3*x + x*x/2)*(3*x + x*x/2)) - 3*(3 + x)*(3 + x)/((3*x + x*x/2)*(3*x + x*x/2)*(3*x + x*x/2)*(3*x + x*x/2)));
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return sqrt(CAUDAL*CAUDAL*(3 + x)/(GRAV*x*(3 + x/2)*(3 + x/2)*(3 + x/2)));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 6 · Civil · Tirante crítico en un canal trapezoidal, Q = 20 m³/s

DESCRIPCION = 'f(y) = 1 - Q^2 B / (g A^3),  A = 3y + y^2/2,  B = 3 + y,  Q = 20'
DESCR_G = 'g(y) = sqrt(Q^2 (3 + y) / (g y (3 + y/2)^3))'

CAUDAL = 20.0   # gasto, m^3/s
GRAV = 9.81   # gravedad, m/s^2

A, B = 0.5, 2.5   # intervalo de los métodos cerrados
X0 = 1.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return 1 - CAUDAL*CAUDAL*(3 + x)/(GRAV*(3*x + x*x/2)*(3*x + x*x/2)*(3*x + x*x/2))


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return -CAUDAL*CAUDAL/GRAV*(1/((3*x + x*x/2)*(3*x + x*x/2)*(3*x + x*x/2)) - 3*(3 + x)*(3 + x)/((3*x + x*x/2)*(3*x + x*x/2)*(3*x + x*x/2)*(3*x + x*x/2)))


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return math.sqrt(CAUDAL*CAUDAL*(3 + x)/(GRAV*x*(3 + x/2)*(3 + x/2)*(3 + x/2)))

# =====================================================================
```

</details>

---

## Computación

<a id="e07"></a>

### 7 · Entrada que un algoritmo n log₂ n procesa con 10⁶ operaciones

Un algoritmo de ordenamiento hace n log₂ n operaciones con una entrada de tamaño n. ¿Qué tamaño de entrada alcanza a procesar con 10⁶ operaciones?

| | |
|---|---|
| f(x) | f(n) = n log₂ n − 10⁶ |
| Despeje para punto fijo | g(n) = 10⁶ / log₂ n |
| Intervalo [a, b] | [10000, 100000] |
| x₀ y δ | x₀ = 50000 · δ = 1 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 7 · Computación · Entrada que un algoritmo n log₂ n procesa con 10⁶ operaciones */

#define DESCRIPCION "f(n) = n log2(n) - 1e6"
#define DESCR_G     "g(n) = 1e6 / log2(n)"

static const double OPS = 1000000.0;   /* operaciones disponibles */

static const double A = 10000.0, B = 100000.0;  /* intervalo de los métodos cerrados */
static const double X0    = 50000.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 1.0;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return x*log2(x) - OPS;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return log2(x) + 1/log(2);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return OPS/log2(x);
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 7 · Computación · Entrada que un algoritmo n log₂ n procesa con 10⁶ operaciones

DESCRIPCION = 'f(n) = n log2(n) - 1e6'
DESCR_G = 'g(n) = 1e6 / log2(n)'

OPS = 1000000.0   # operaciones disponibles

A, B = 10000.0, 100000.0   # intervalo de los métodos cerrados
X0 = 50000.0         # inicio de los métodos abiertos
DELTA = 1.0      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return x*math.log2(x) - OPS


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return math.log2(x) + 1/math.log(2)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return OPS/math.log2(x)

# =====================================================================
```

</details>

<a id="e08"></a>

### 8 · Trazado de rayos: dónde choca un rayo con un cubo redondeado

Para dibujar una superficie implícita, un trazador de rayos busca el primer t en el que el rayo p(t) = o + t·d la toca. Superficie x⁴ + y⁴ + z⁴ = 1 (un cubo de esquinas redondeadas), origen o = (−2, −0.6, −0.8) y dirección unitaria d = (0.8, 0.36, 0.48).

| | |
|---|---|
| f(x) | f(t) = X⁴ + Y⁴ + Z⁴ − 1,  X = −2 + 0.8t,  Y = −0.6 + 0.36t,  Z = −0.8 + 0.48t |
| Despeje para punto fijo | g(t) = t + f(t)/4 |
| Intervalo [a, b] | [0, 1.5] |
| x₀ y δ | x₀ = 0.5 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 8 · Computación · Trazado de rayos: dónde choca un rayo con un cubo redondeado */

#define DESCRIPCION "f(t) = X^4 + Y^4 + Z^4 - 1,  (X, Y, Z) = (-2, -0.6, -0.8) + t (0.8, 0.36, 0.48)"
#define DESCR_G     "g(t) = t + f(t) / 4"

static const double OX = -2.0;   /* origen del rayo */
static const double OY = -0.6;
static const double OZ = -0.8;
static const double DX = 0.8;   /* dirección del rayo, unitaria */
static const double DY = 0.36;
static const double DZ = 0.48;

static const double A = 0.0, B = 1.5;  /* intervalo de los métodos cerrados */
static const double X0    = 0.5;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return (OX + DX*x)*(OX + DX*x)*(OX + DX*x)*(OX + DX*x) + (OY + DY*x)*(OY + DY*x)*(OY + DY*x)*(OY + DY*x) + (OZ + DZ*x)*(OZ + DZ*x)*(OZ + DZ*x)*(OZ + DZ*x) - 1;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return 4*DX*(OX + DX*x)*(OX + DX*x)*(OX + DX*x) + 4*DY*(OY + DY*x)*(OY + DY*x)*(OY + DY*x) + 4*DZ*(OZ + DZ*x)*(OZ + DZ*x)*(OZ + DZ*x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return x + f(x)/4;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 8 · Computación · Trazado de rayos: dónde choca un rayo con un cubo redondeado

DESCRIPCION = 'f(t) = X^4 + Y^4 + Z^4 - 1,  (X, Y, Z) = (-2, -0.6, -0.8) + t (0.8, 0.36, 0.48)'
DESCR_G = 'g(t) = t + f(t) / 4'

OX = -2.0   # origen del rayo
OY = -0.6
OZ = -0.8
DX = 0.8   # dirección del rayo, unitaria
DY = 0.36
DZ = 0.48

A, B = 0.0, 1.5   # intervalo de los métodos cerrados
X0 = 0.5         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return (OX + DX*x)*(OX + DX*x)*(OX + DX*x)*(OX + DX*x) + (OY + DY*x)*(OY + DY*x)*(OY + DY*x)*(OY + DY*x) + (OZ + DZ*x)*(OZ + DZ*x)*(OZ + DZ*x)*(OZ + DZ*x) - 1


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return 4*DX*(OX + DX*x)*(OX + DX*x)*(OX + DX*x) + 4*DY*(OY + DY*x)*(OY + DY*x)*(OY + DY*x) + 4*DZ*(OZ + DZ*x)*(OZ + DZ*x)*(OZ + DZ*x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return x + f(x)/4

# =====================================================================
```

</details>

<a id="e09"></a>

### 9 · Canal binario simétrico: probabilidad de error con capacidad de 0.5 bits

Un canal binario simétrico invierte cada bit con probabilidad p. Su capacidad es C = 1 − H(p) bits por uso, con H(p) = −p log₂ p − (1 − p) log₂(1 − p) la entropía binaria. ¿Con qué p la capacidad baja a la mitad?

| | |
|---|---|
| f(x) | f(p) = −p log₂ p − (1 − p) log₂(1 − p) − (1 − C),  C = 0.5 |
| Despeje para punto fijo | g(p) = (1 − C + (1 − p) log₂(1 − p)) / (−log₂ p) |
| Intervalo [a, b] | [0.01, 0.4] |
| x₀ y δ | x₀ = 0.2 · δ = 0.001 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 9 · Computación · Canal binario simétrico: probabilidad de error con capacidad de 0.5 bits */

#define DESCRIPCION "f(p) = -p log2(p) - (1 - p) log2(1 - p) - (1 - C),  C = 0.5"
#define DESCR_G     "g(p) = (1 - C + (1 - p) log2(1 - p)) / (-log2(p))"

static const double CAP = 0.5;   /* capacidad del canal, bits por uso */

static const double A = 0.01, B = 0.4;  /* intervalo de los métodos cerrados */
static const double X0    = 0.2;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.001;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return -x*log2(x) - (1 - x)*log2(1 - x) - (1 - CAP);
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return log2(1 - x) - log2(x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return (1 - CAP + (1 - x)*log2(1 - x))/(-log2(x));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 9 · Computación · Canal binario simétrico: probabilidad de error con capacidad de 0.5 bits

DESCRIPCION = 'f(p) = -p log2(p) - (1 - p) log2(1 - p) - (1 - C),  C = 0.5'
DESCR_G = 'g(p) = (1 - C + (1 - p) log2(1 - p)) / (-log2(p))'

CAP = 0.5   # capacidad del canal, bits por uso

A, B = 0.01, 0.4   # intervalo de los métodos cerrados
X0 = 0.2         # inicio de los métodos abiertos
DELTA = 0.001      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return -x*math.log2(x) - (1 - x)*math.log2(1 - x) - (1 - CAP)


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return math.log2(1 - x) - math.log2(x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return (1 - CAP + (1 - x)*math.log2(1 - x))/(-math.log2(x))

# =====================================================================
```

</details>

---

## Eléctrica

<a id="e10"></a>

### 10 · Resistencia que disipa al 1 % la carga de un circuito RLC

Al cerrar el interruptor, la carga del capacitor de un circuito RLC (L = 5 H, C = 10⁻⁴ F) decae como q/q₀ = e^(−Rt/2L) cos(√(1/LC − (R/2L)²) t). ¿Qué resistencia R (Ω) deja la carga en 1 % a los 0.05 s?

| | |
|---|---|
| f(x) | f(R) = e^(−0.005R) cos(0.05 √(2000 − 0.01R²)) − 0.01 |
| Despeje para punto fijo | g(R) = R − 1000 f(R) |
| Intervalo [a, b] | [200, 400] |
| x₀ y δ | x₀ = 300 · δ = 0.5 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 10 · Eléctrica · Resistencia que disipa al 1 % la carga de un circuito RLC */

#define DESCRIPCION "f(R) = exp(-0.005 R) cos(0.05 sqrt(2000 - 0.01 R^2)) - 0.01"
#define DESCR_G     "g(R) = R - 1000 f(R)"


static const double A = 200.0, B = 400.0;  /* intervalo de los métodos cerrados */
static const double X0    = 300.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.5;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return exp(-0.005*x) * cos(0.05*sqrt(2000 - 0.01*x*x)) - 0.01;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return -0.005*exp(-0.005*x) * cos(0.05*sqrt(2000 - 0.01*x*x)) + exp(-0.005*x) * sin(0.05*sqrt(2000 - 0.01*x*x)) * 0.05*0.01*x / sqrt(2000 - 0.01*x*x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return x - 1000*f(x);
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 10 · Eléctrica · Resistencia que disipa al 1 % la carga de un circuito RLC

DESCRIPCION = 'f(R) = exp(-0.005 R) cos(0.05 sqrt(2000 - 0.01 R^2)) - 0.01'
DESCR_G = 'g(R) = R - 1000 f(R)'


A, B = 200.0, 400.0   # intervalo de los métodos cerrados
X0 = 300.0         # inicio de los métodos abiertos
DELTA = 0.5      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return math.exp(-0.005*x) * math.cos(0.05*math.sqrt(2000 - 0.01*x*x)) - 0.01


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return -0.005*math.exp(-0.005*x) * math.cos(0.05*math.sqrt(2000 - 0.01*x*x)) + math.exp(-0.005*x) * math.sin(0.05*math.sqrt(2000 - 0.01*x*x)) * 0.05*0.01*x / math.sqrt(2000 - 0.01*x*x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return x - 1000*f(x)

# =====================================================================
```

</details>

<a id="e11"></a>

### 11 · Ángulo de carga de un generador síncrono de polos salientes

Un generador de polos salientes entrega P = (EV/X_d) sen δ + (V²/2)(1/X_q − 1/X_d) sen 2δ. Con E = 1.5, V = 1, X_d = 1 y X_q = 0.6 (en por unidad), ¿con qué ángulo de carga δ (rad) entrega P = 1.2?

| | |
|---|---|
| f(x) | f(δ) = (EV/X_d) sen δ + (V²/2)(1/X_q − 1/X_d) sen 2δ − P |
| Despeje para punto fijo | g(δ) = δ − f(δ)/2 |
| Intervalo [a, b] | [0, 1.5] |
| x₀ y δ | x₀ = 0.5 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 11 · Eléctrica · Ángulo de carga de un generador síncrono de polos salientes */

#define DESCRIPCION "f(d) = E V / Xd sin(d) + V^2 / 2 (1/Xq - 1/Xd) sin(2 d) - P,  E = 1.5, V = 1, Xd = 1, Xq = 0.6, P = 1.2"
#define DESCR_G     "g(d) = d - f(d) / 2"

static const double EINT = 1.5;   /* voltaje interno, pu */
static const double VTER = 1.0;   /* voltaje en terminales, pu */
static const double XD = 1.0;   /* reactancia de eje directo, pu */
static const double XQ = 0.6;   /* reactancia de eje en cuadratura, pu */
static const double POT = 1.2;   /* potencia que entrega, pu */

static const double A = 0.0, B = 1.5;  /* intervalo de los métodos cerrados */
static const double X0    = 0.5;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return EINT*VTER/XD*sin(x) + VTER*VTER/2*(1/XQ - 1/XD)*sin(2*x) - POT;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return EINT*VTER/XD*cos(x) + VTER*VTER*(1/XQ - 1/XD)*cos(2*x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return x - f(x)/2;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 11 · Eléctrica · Ángulo de carga de un generador síncrono de polos salientes

DESCRIPCION = 'f(d) = E V / Xd sin(d) + V^2 / 2 (1/Xq - 1/Xd) sin(2 d) - P,  E = 1.5, V = 1, Xd = 1, Xq = 0.6, P = 1.2'
DESCR_G = 'g(d) = d - f(d) / 2'

EINT = 1.5   # voltaje interno, pu
VTER = 1.0   # voltaje en terminales, pu
XD = 1.0   # reactancia de eje directo, pu
XQ = 0.6   # reactancia de eje en cuadratura, pu
POT = 1.2   # potencia que entrega, pu

A, B = 0.0, 1.5   # intervalo de los métodos cerrados
X0 = 0.5         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return EINT*VTER/XD*math.sin(x) + VTER*VTER/2*(1/XQ - 1/XD)*math.sin(2*x) - POT


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return EINT*VTER/XD*math.cos(x) + VTER*VTER*(1/XQ - 1/XD)*math.cos(2*x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return x - f(x)/2

# =====================================================================
```

</details>

<a id="e12"></a>

### 12 · Tensión de un conductor de línea aérea, vano de 300 m

El conductor de una línea de transmisión pesa w = 0.015 kN/m y cuelga entre dos torres separadas L = 300 m. Cuelga como una catenaria: su flecha es s = (T/w)(cosh(wL/2T) − 1). ¿Qué tensión horizontal T (kN) deja una flecha de 6 m?

| | |
|---|---|
| f(x) | f(T) = (T/w)(cosh(wL/(2T)) − 1) − s,  cosh u = (eᵘ + e⁻ᵘ)/2 |
| Despeje para punto fijo | g(T) = (wL²/(8s)) · 2(cosh u − 1)/u²,  u = wL/(2T) |
| Intervalo [a, b] | [10, 60] |
| x₀ y δ | x₀ = 20 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 12 · Eléctrica · Tensión de un conductor de línea aérea, vano de 300 m */

#define DESCRIPCION "f(T) = T/w (cosh(w L / (2 T)) - 1) - s,  w = 0.015, L = 300, s = 6"
#define DESCR_G     "g(T) = w L^2 / (8 s) * 2 (cosh(u) - 1) / u^2,  u = w L / (2 T)"

static const double PESO = 0.015;   /* peso del conductor, kN/m */
static const double VANO = 300.0;   /* distancia entre torres, m */
static const double FLECHA = 6.0;   /* flecha permitida, m */

static const double A = 10.0, B = 60.0;  /* intervalo de los métodos cerrados */
static const double X0    = 20.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return x/PESO*((exp(PESO*VANO/(2*x)) + exp(-PESO*VANO/(2*x)))/2 - 1) - FLECHA;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return ((exp(PESO*VANO/(2*x)) + exp(-PESO*VANO/(2*x)))/2 - 1 - PESO*VANO/(2*x)*(exp(PESO*VANO/(2*x)) - exp(-PESO*VANO/(2*x)))/2)/PESO;
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return PESO*VANO*VANO/(4*FLECHA)*((exp(PESO*VANO/(2*x)) + exp(-PESO*VANO/(2*x)))/2 - 1)/((PESO*VANO/(2*x))*(PESO*VANO/(2*x)));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 12 · Eléctrica · Tensión de un conductor de línea aérea, vano de 300 m

DESCRIPCION = 'f(T) = T/w (cosh(w L / (2 T)) - 1) - s,  w = 0.015, L = 300, s = 6'
DESCR_G = 'g(T) = w L^2 / (8 s) * 2 (cosh(u) - 1) / u^2,  u = w L / (2 T)'

PESO = 0.015   # peso del conductor, kN/m
VANO = 300.0   # distancia entre torres, m
FLECHA = 6.0   # flecha permitida, m

A, B = 10.0, 60.0   # intervalo de los métodos cerrados
X0 = 20.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return x/PESO*((math.exp(PESO*VANO/(2*x)) + math.exp(-PESO*VANO/(2*x)))/2 - 1) - FLECHA


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return ((math.exp(PESO*VANO/(2*x)) + math.exp(-PESO*VANO/(2*x)))/2 - 1 - PESO*VANO/(2*x)*(math.exp(PESO*VANO/(2*x)) - math.exp(-PESO*VANO/(2*x)))/2)/PESO


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return PESO*VANO*VANO/(4*FLECHA)*((math.exp(PESO*VANO/(2*x)) + math.exp(-PESO*VANO/(2*x)))/2 - 1)/((PESO*VANO/(2*x))*(PESO*VANO/(2*x)))

# =====================================================================
```

</details>

---

## Electrónica

<a id="e13"></a>

### 13 · Voltaje en un diodo con resistencia en serie

Un diodo de silicio está en serie con una resistencia de 1 kΩ y una fuente de 5 V. La corriente del diodo, Is(e^(V/VT) − 1), es la misma que pasa por la resistencia, (5 − V)/1000. ¿Cuál es el voltaje V (V) del diodo?

| | |
|---|---|
| f(x) | f(V) = Is (e^(V/VT) − 1) − (5 − V)/1000,  Is = 10⁻¹², VT = 0.02585 |
| Despeje para punto fijo | g(V) = VT ln((5 − V) / (1000 Is) + 1) |
| Intervalo [a, b] | [0, 1] |
| x₀ y δ | x₀ = 0.7 · δ = 0.001 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 13 · Electrónica · Voltaje en un diodo con resistencia en serie */

#define DESCRIPCION "f(V) = Is (exp(V/VT) - 1) - (5 - V)/1000,  Is = 1e-12, VT = 0.02585"
#define DESCR_G     "g(V) = VT ln((5 - V) / (1000 Is) + 1)"

static const double IS = 1e-12;   /* corriente de saturación, A */
static const double VT = 0.02585;   /* voltaje térmico, V */
static const double VS = 5.0;   /* fuente, V */
static const double RES = 1000.0;   /* resistencia, ohm */

static const double A = 0.0, B = 1.0;  /* intervalo de los métodos cerrados */
static const double X0    = 0.7;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.001;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return IS*(exp(x/VT) - 1) - (VS - x)/RES;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return IS/VT*exp(x/VT) + 1/RES;
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return VT*log((VS - x)/(RES*IS) + 1);
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 13 · Electrónica · Voltaje en un diodo con resistencia en serie

DESCRIPCION = 'f(V) = Is (exp(V/VT) - 1) - (5 - V)/1000,  Is = 1e-12, VT = 0.02585'
DESCR_G = 'g(V) = VT ln((5 - V) / (1000 Is) + 1)'

IS = 1e-12   # corriente de saturación, A
VT = 0.02585   # voltaje térmico, V
VS = 5.0   # fuente, V
RES = 1000.0   # resistencia, ohm

A, B = 0.0, 1.0   # intervalo de los métodos cerrados
X0 = 0.7         # inicio de los métodos abiertos
DELTA = 0.001      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return IS*(math.exp(x/VT) - 1) - (VS - x)/RES


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return IS/VT*math.exp(x/VT) + 1/RES


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return VT*math.log((VS - x)/(RES*IS) + 1)

# =====================================================================
```

</details>

<a id="e14"></a>

### 14 · Ángulo de extinción de un rectificador de media onda con carga RL

En un rectificador de media onda con carga RL, la corriente sigue circulando después de que el voltaje cambia de signo y se apaga en el ángulo β (rad) donde sen(β − θ) + sen θ e^(−β/tan θ) = 0, con tan θ = ωL/R. Al multiplicar por √(1 + (ωL/R)²) queda la ecuación de abajo, con Q = ωL/R = 2.

| | |
|---|---|
| f(x) | f(β) = sen β − Q cos β + Q e^(−β/Q),  Q = ωL/R = 2 |
| Despeje para punto fijo | g(β) = β + f(β)/2 |
| Intervalo [a, b] | [3, 6] |
| x₀ y δ | x₀ = 4 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 14 · Electrónica · Ángulo de extinción de un rectificador de media onda con carga RL */

#define DESCRIPCION "f(b) = sin(b) - Q cos(b) + Q exp(-b / Q),  Q = wL/R = 2"
#define DESCR_G     "g(b) = b + f(b) / 2"

static const double WLR = 2.0;   /* cociente wL/R de la carga */

static const double A = 3.0, B = 6.0;  /* intervalo de los métodos cerrados */
static const double X0    = 4.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return sin(x) - WLR*cos(x) + WLR*exp(-x/WLR);
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return cos(x) + WLR*sin(x) - exp(-x/WLR);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return x + f(x)/2;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 14 · Electrónica · Ángulo de extinción de un rectificador de media onda con carga RL

DESCRIPCION = 'f(b) = sin(b) - Q cos(b) + Q exp(-b / Q),  Q = wL/R = 2'
DESCR_G = 'g(b) = b + f(b) / 2'

WLR = 2.0   # cociente wL/R de la carga

A, B = 3.0, 6.0   # intervalo de los métodos cerrados
X0 = 4.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return math.sin(x) - WLR*math.cos(x) + WLR*math.exp(-x/WLR)


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return math.cos(x) + WLR*math.sin(x) - math.exp(-x/WLR)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return x + f(x)/2

# =====================================================================
```

</details>

<a id="e15"></a>

### 15 · Resistencia de un termistor NTC a 37 °C (Steinhart-Hart)

Un termómetro electrónico usa un termistor NTC de 10 kΩ. Su resistencia R (Ω) y su temperatura T (K) cumplen la ecuación de Steinhart-Hart, 1/T = A + B ln R + C (ln R)³. ¿Qué resistencia tiene a 37 °C (310.15 K)?

| | |
|---|---|
| f(x) | f(R) = A + B ln R + C (ln R)³ − 1/T,  A = 1.129148×10⁻³, B = 2.34125×10⁻⁴, C = 8.76741×10⁻⁸, T = 310.15 |
| Despeje para punto fijo | g(R) = exp((1/T − A − C (ln R)³) / B) |
| Intervalo [a, b] | [1000, 20000] |
| x₀ y δ | x₀ = 5000 · δ = 1 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 15 · Electrónica · Resistencia de un termistor NTC a 37 °C (Steinhart-Hart) */

#define DESCRIPCION "f(R) = A + B ln(R) + C ln(R)^3 - 1/T,  A = 1.129148e-3, B = 2.34125e-4, C = 8.76741e-8, T = 310.15"
#define DESCR_G     "g(R) = exp((1/T - A - C ln(R)^3) / B)"

static const double SHA = 0.001129148;   /* coeficiente A de Steinhart-Hart */
static const double SHB = 0.000234125;   /* coeficiente B */
static const double SHC = 8.76741e-08;   /* coeficiente C */
static const double TEMP = 310.15;   /* temperatura, K */

static const double A = 1000.0, B = 20000.0;  /* intervalo de los métodos cerrados */
static const double X0    = 5000.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 1.0;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return SHA + SHB*log(x) + SHC*log(x)*log(x)*log(x) - 1/TEMP;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return SHB/x + 3*SHC*log(x)*log(x)/x;
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return exp((1/TEMP - SHA - SHC*log(x)*log(x)*log(x))/SHB);
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 15 · Electrónica · Resistencia de un termistor NTC a 37 °C (Steinhart-Hart)

DESCRIPCION = 'f(R) = A + B ln(R) + C ln(R)^3 - 1/T,  A = 1.129148e-3, B = 2.34125e-4, C = 8.76741e-8, T = 310.15'
DESCR_G = 'g(R) = exp((1/T - A - C ln(R)^3) / B)'

SHA = 0.001129148   # coeficiente A de Steinhart-Hart
SHB = 0.000234125   # coeficiente B
SHC = 8.76741e-08   # coeficiente C
TEMP = 310.15   # temperatura, K

A, B = 1000.0, 20000.0   # intervalo de los métodos cerrados
X0 = 5000.0         # inicio de los métodos abiertos
DELTA = 1.0      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return SHA + SHB*math.log(x) + SHC*math.log(x)*math.log(x)*math.log(x) - 1/TEMP


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return SHB/x + 3*SHC*math.log(x)*math.log(x)/x


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return math.exp((1/TEMP - SHA - SHC*math.log(x)*math.log(x)*math.log(x))/SHB)

# =====================================================================
```

</details>

---

## Física

<a id="e16"></a>

### 16 · Ecuación de Kepler, e = 0.5, M = 1.2 rad

La posición de un planeta en su órbita elíptica sale de la ecuación de Kepler, M = E − e sen E: dada la anomalía media M, se busca la anomalía excéntrica E (rad). Órbita con excentricidad e = 0.5 y M = 1.2 rad.

| | |
|---|---|
| f(x) | f(E) = E − 0.5 sen E − 1.2 |
| Despeje para punto fijo | g(E) = 1.2 + 0.5 sen E |
| Intervalo [a, b] | [1, 2.5] |
| x₀ y δ | x₀ = 1.5 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 16 · Física · Ecuación de Kepler, e = 0.5, M = 1.2 rad */

#define DESCRIPCION "f(E) = E - 0.5 sin(E) - 1.2"
#define DESCR_G     "g(E) = 1.2 + 0.5 sin(E)"

static const double EXC = 0.5;   /* excentricidad de la órbita */
static const double MED = 1.2;   /* anomalía media, rad */

static const double A = 1.0, B = 2.5;  /* intervalo de los métodos cerrados */
static const double X0    = 1.5;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return x - EXC*sin(x) - MED;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return 1 - EXC*cos(x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return MED + EXC*sin(x);
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 16 · Física · Ecuación de Kepler, e = 0.5, M = 1.2 rad

DESCRIPCION = 'f(E) = E - 0.5 sin(E) - 1.2'
DESCR_G = 'g(E) = 1.2 + 0.5 sin(E)'

EXC = 0.5   # excentricidad de la órbita
MED = 1.2   # anomalía media, rad

A, B = 1.0, 2.5   # intervalo de los métodos cerrados
X0 = 1.5         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return x - EXC*math.sin(x) - MED


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return 1 - EXC*math.cos(x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return MED + EXC*math.sin(x)

# =====================================================================
```

</details>

<a id="e17"></a>

### 17 · Ley de desplazamiento de Wien: el máximo del espectro de cuerpo negro

La longitud de onda en la que más emite un cuerpo negro sale de derivar la ley de Planck e igualar a cero; con x = hc/(λkT) queda x = 5(1 − e^(−x)). Su raíz da la constante de Wien: λ_max T = hc/(kx) ≈ 2.898×10⁻³ m·K.

| | |
|---|---|
| f(x) | f(x) = x − 5 + 5e^(−x) |
| Despeje para punto fijo | g(x) = 5(1 − e^(−x)) |
| Intervalo [a, b] | [1, 8] |
| x₀ y δ | x₀ = 4 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 17 · Física · Ley de desplazamiento de Wien: el máximo del espectro de cuerpo negro */

#define DESCRIPCION "f(x) = x - 5 + 5 exp(-x)"
#define DESCR_G     "g(x) = 5 (1 - exp(-x))"


static const double A = 1.0, B = 8.0;  /* intervalo de los métodos cerrados */
static const double X0    = 4.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return x - 5 + 5*exp(-x);
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return 1 - 5*exp(-x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return 5*(1 - exp(-x));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 17 · Física · Ley de desplazamiento de Wien: el máximo del espectro de cuerpo negro

DESCRIPCION = 'f(x) = x - 5 + 5 exp(-x)'
DESCR_G = 'g(x) = 5 (1 - exp(-x))'


A, B = 1.0, 8.0   # intervalo de los métodos cerrados
X0 = 4.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return x - 5 + 5*math.exp(-x)


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return 1 - 5*math.exp(-x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return 5*(1 - math.exp(-x))

# =====================================================================
```

</details>

<a id="e18"></a>

### 18 · Punto de Lagrange L1 entre la Tierra y la Luna

Entre la Tierra y la Luna hay un punto, L1, donde una nave gira junto con la Luna sin acercarse ni alejarse. Su distancia a la Tierra, x (en unidades de la distancia Tierra-Luna, 384 400 km), equilibra las dos atracciones y la fuerza centrífuga; μ = M_Luna/(M_Tierra + M_Luna) = 0.01215.

| | |
|---|---|
| f(x) | f(x) = (1 − μ)/x² − μ/(1 − x)² − (x − μ),  μ = 0.01215 |
| Despeje para punto fijo | g(x) = 1 − √(μ / ((1 − μ)/x² − x + μ)) |
| Intervalo [a, b] | [0.5, 0.95] |
| x₀ y δ | x₀ = 0.8 · δ = 0.001 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 18 · Física · Punto de Lagrange L1 entre la Tierra y la Luna */

#define DESCRIPCION "f(x) = (1 - mu)/x^2 - mu/(1 - x)^2 - (x - mu),  mu = 0.01215"
#define DESCR_G     "g(x) = 1 - sqrt(mu / ((1 - mu)/x^2 - x + mu))"

static const double MU = 0.01215;   /* masa de la Luna / masa total */

static const double A = 0.5, B = 0.95;  /* intervalo de los métodos cerrados */
static const double X0    = 0.8;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.001;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return (1 - MU)/(x*x) - MU/((1 - x)*(1 - x)) - (x - MU);
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return -2*(1 - MU)/(x*x*x) - 2*MU/((1 - x)*(1 - x)*(1 - x)) - 1;
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return 1 - sqrt(MU/((1 - MU)/(x*x) - x + MU));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 18 · Física · Punto de Lagrange L1 entre la Tierra y la Luna

DESCRIPCION = 'f(x) = (1 - mu)/x^2 - mu/(1 - x)^2 - (x - mu),  mu = 0.01215'
DESCR_G = 'g(x) = 1 - sqrt(mu / ((1 - mu)/x^2 - x + mu))'

MU = 0.01215   # masa de la Luna / masa total

A, B = 0.5, 0.95   # intervalo de los métodos cerrados
X0 = 0.8         # inicio de los métodos abiertos
DELTA = 0.001      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return (1 - MU)/(x*x) - MU/((1 - x)*(1 - x)) - (x - MU)


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return -2*(1 - MU)/(x*x*x) - 2*MU/((1 - x)*(1 - x)*(1 - x)) - 1


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return 1 - math.sqrt(MU/((1 - MU)/(x*x) - x + MU))

# =====================================================================
```

</details>

---

## Industrial

<a id="e19"></a>

### 19 · Tasa interna de retorno: invierte 25 000, recibe 5 pagos de 8 000

Un proyecto cuesta 25 000 pesos hoy y devuelve 8 000 al final de cada uno de los próximos 5 años. Su tasa interna de retorno i es la tasa con la que el valor presente de los pagos iguala la inversión.

| | |
|---|---|
| f(x) | f(i) = 8000 (1 − (1 + i)⁻⁵) / i − 25000 |
| Despeje para punto fijo | g(i) = 0.32 (1 − (1 + i)⁻⁵) |
| Intervalo [a, b] | [0.05, 0.4] |
| x₀ y δ | x₀ = 0.1 · δ = 0.001 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 19 · Industrial · Tasa interna de retorno: invierte 25 000, recibe 5 pagos de 8 000 */

#define DESCRIPCION "f(i) = 8000 (1 - (1 + i)^-5) / i - 25000"
#define DESCR_G     "g(i) = 0.32 (1 - (1 + i)^-5)"

static const double PAGO = 8000.0;   /* pago anual */
static const double INV = 25000.0;   /* inversión inicial */

static const double A = 0.05, B = 0.4;  /* intervalo de los métodos cerrados */
static const double X0    = 0.1;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.001;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return PAGO*(1 - 1/((1+x)*(1+x)*(1+x)*(1+x)*(1+x)))/x - INV;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return PAGO*(5/((1+x)*(1+x)*(1+x)*(1+x)*(1+x)*(1+x))/x - (1 - 1/((1+x)*(1+x)*(1+x)*(1+x)*(1+x)))/(x*x));
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return PAGO/INV*(1 - 1/((1+x)*(1+x)*(1+x)*(1+x)*(1+x)));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 19 · Industrial · Tasa interna de retorno: invierte 25 000, recibe 5 pagos de 8 000

DESCRIPCION = 'f(i) = 8000 (1 - (1 + i)^-5) / i - 25000'
DESCR_G = 'g(i) = 0.32 (1 - (1 + i)^-5)'

PAGO = 8000.0   # pago anual
INV = 25000.0   # inversión inicial

A, B = 0.05, 0.4   # intervalo de los métodos cerrados
X0 = 0.1         # inicio de los métodos abiertos
DELTA = 0.001      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return PAGO*(1 - 1/((1+x)*(1+x)*(1+x)*(1+x)*(1+x)))/x - INV


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return PAGO*(5/((1+x)*(1+x)*(1+x)*(1+x)*(1+x)*(1+x))/x - (1 - 1/((1+x)*(1+x)*(1+x)*(1+x)*(1+x)))/(x*x))


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return PAGO/INV*(1 - 1/((1+x)*(1+x)*(1+x)*(1+x)*(1+x)))

# =====================================================================
```

</details>

<a id="e20"></a>

### 20 · Tiempo de misión de dos máquinas en paralelo con confiabilidad de 95 %

Una línea de producción funciona mientras trabaje al menos una de dos máquinas en paralelo, con tasas de falla λ₁ = 0.001/h y λ₂ = 0.002/h. Su confiabilidad es R(t) = e^(−λ₁t) + e^(−λ₂t) − e^(−(λ₁+λ₂)t). ¿Hasta qué tiempo t (h) se mantiene en 95 %?

| | |
|---|---|
| f(x) | f(t) = e^(−λ₁t) + e^(−λ₂t) − e^(−(λ₁+λ₂)t) − 0.95 |
| Despeje para punto fijo | g(t) = t √(0.05 / ((1 − e^(−λ₁t))(1 − e^(−λ₂t)))) |
| Intervalo [a, b] | [10, 1000] |
| x₀ y δ | x₀ = 100 · δ = 0.1 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 20 · Industrial · Tiempo de misión de dos máquinas en paralelo con confiabilidad de 95 % */

#define DESCRIPCION "f(t) = exp(-l1 t) + exp(-l2 t) - exp(-(l1 + l2) t) - 0.95,  l1 = 0.001, l2 = 0.002"
#define DESCR_G     "g(t) = t sqrt(0.05 / ((1 - exp(-l1 t)) (1 - exp(-l2 t))))"

static const double LAM1 = 0.001;   /* tasa de falla de la máquina 1, 1/h */
static const double LAM2 = 0.002;   /* tasa de falla de la máquina 2, 1/h */
static const double RMIN = 0.95;   /* confiabilidad pedida */

static const double A = 10.0, B = 1000.0;  /* intervalo de los métodos cerrados */
static const double X0    = 100.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.1;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return exp(-LAM1*x) + exp(-LAM2*x) - exp(-(LAM1 + LAM2)*x) - RMIN;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return -LAM1*exp(-LAM1*x) - LAM2*exp(-LAM2*x) + (LAM1 + LAM2)*exp(-(LAM1 + LAM2)*x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return x*sqrt((1 - RMIN)/((1 - exp(-LAM1*x))*(1 - exp(-LAM2*x))));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 20 · Industrial · Tiempo de misión de dos máquinas en paralelo con confiabilidad de 95 %

DESCRIPCION = 'f(t) = exp(-l1 t) + exp(-l2 t) - exp(-(l1 + l2) t) - 0.95,  l1 = 0.001, l2 = 0.002'
DESCR_G = 'g(t) = t sqrt(0.05 / ((1 - exp(-l1 t)) (1 - exp(-l2 t))))'

LAM1 = 0.001   # tasa de falla de la máquina 1, 1/h
LAM2 = 0.002   # tasa de falla de la máquina 2, 1/h
RMIN = 0.95   # confiabilidad pedida

A, B = 10.0, 1000.0   # intervalo de los métodos cerrados
X0 = 100.0         # inicio de los métodos abiertos
DELTA = 0.1      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return math.exp(-LAM1*x) + math.exp(-LAM2*x) - math.exp(-(LAM1 + LAM2)*x) - RMIN


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return -LAM1*math.exp(-LAM1*x) - LAM2*math.exp(-LAM2*x) + (LAM1 + LAM2)*math.exp(-(LAM1 + LAM2)*x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return x*math.sqrt((1 - RMIN)/((1 - math.exp(-LAM1*x))*(1 - math.exp(-LAM2*x))))

# =====================================================================
```

</details>

<a id="e21"></a>

### 21 · Cada cuántos años conviene reemplazar una máquina

Una máquina cuesta A = 80 mil pesos y su mantenimiento crece como 10 e^(0.2t) mil pesos por año. El costo promedio anual, (compra + mantenimiento acumulado)/T, es mínimo donde su derivada vale cero, y eso da la ecuación de abajo. ¿Cada cuántos años T conviene reemplazarla?

| | |
|---|---|
| f(x) | f(T) = c₀ T e^(αT) − c₀(e^(αT) − 1)/α − A,  A = 80, c₀ = 10, α = 0.2 |
| Despeje para punto fijo | g(T) = 1/α + (A − c₀/α) e^(−αT) / c₀ |
| Intervalo [a, b] | [1, 10] |
| x₀ y δ | x₀ = 3 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 21 · Industrial · Cada cuántos años conviene reemplazar una máquina */

#define DESCRIPCION "f(T) = c0 T exp(a T) - c0 (exp(a T) - 1) / a - A,  A = 80, c0 = 10, a = 0.2"
#define DESCR_G     "g(T) = 1/a + (A - c0/a) exp(-a T) / c0"

static const double COMPRA = 80.0;   /* precio de la máquina, miles de pesos */
static const double CMANT = 10.0;   /* mantenimiento inicial, miles de pesos por año */
static const double ALFA = 0.2;   /* crecimiento del mantenimiento, 1/año */

static const double A = 1.0, B = 10.0;  /* intervalo de los métodos cerrados */
static const double X0    = 3.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return CMANT*x*exp(ALFA*x) - CMANT*(exp(ALFA*x) - 1)/ALFA - COMPRA;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return CMANT*ALFA*x*exp(ALFA*x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return 1/ALFA + (COMPRA - CMANT/ALFA)*exp(-ALFA*x)/CMANT;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 21 · Industrial · Cada cuántos años conviene reemplazar una máquina

DESCRIPCION = 'f(T) = c0 T exp(a T) - c0 (exp(a T) - 1) / a - A,  A = 80, c0 = 10, a = 0.2'
DESCR_G = 'g(T) = 1/a + (A - c0/a) exp(-a T) / c0'

COMPRA = 80.0   # precio de la máquina, miles de pesos
CMANT = 10.0   # mantenimiento inicial, miles de pesos por año
ALFA = 0.2   # crecimiento del mantenimiento, 1/año

A, B = 1.0, 10.0   # intervalo de los métodos cerrados
X0 = 3.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return CMANT*x*math.exp(ALFA*x) - CMANT*(math.exp(ALFA*x) - 1)/ALFA - COMPRA


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return CMANT*ALFA*x*math.exp(ALFA*x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return 1/ALFA + (COMPRA - CMANT/ALFA)*math.exp(-ALFA*x)/CMANT

# =====================================================================
```

</details>

---

## Mecánica

<a id="e22"></a>

### 22 · Mecanismo de cuatro barras: ángulo del balancín (Freudenstein)

En un mecanismo de cuatro barras con manivela a = 40 mm, acoplador b = 120 mm, balancín c = 80 mm y bancada d = 100 mm, la ecuación de Freudenstein relaciona el ángulo de la manivela, θ₂, con el del balancín, θ₄. Con θ₂ = 60°, ¿cuánto vale θ₄ (rad)?

| | |
|---|---|
| f(x) | f(θ₄) = (d/a) cos θ₄ − (d/c) cos θ₂ + (a² − b² + c² + d²)/(2ac) − cos(θ₂ − θ₄),  θ₂ = 60° |
| Despeje para punto fijo | g(θ₄) = θ₄ + f(θ₄)/2 |
| Intervalo [a, b] | [0.5, 1.5] |
| x₀ y δ | x₀ = 1 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 22 · Mecánica · Mecanismo de cuatro barras: ángulo del balancín (Freudenstein) */

#define DESCRIPCION "f(t4) = d/a cos(t4) - d/c cos(t2) + (a^2 - b^2 + c^2 + d^2)/(2 a c) - cos(t2 - t4),  a = 40, b = 120, c = 80, d = 100, t2 = 60 grados"
#define DESCR_G     "g(t4) = t4 + f(t4) / 2"

static const double LA = 40.0;   /* manivela, mm */
static const double LB = 120.0;   /* acoplador, mm */
static const double LC = 80.0;   /* balancín, mm */
static const double LD = 100.0;   /* bancada, mm */
static const double TH2 = 1.0471975511965976;   /* ángulo de la manivela, rad (60 grados) */

static const double A = 0.5, B = 1.5;  /* intervalo de los métodos cerrados */
static const double X0    = 1.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return LD/LA*cos(x) - LD/LC*cos(TH2) + (LA*LA - LB*LB + LC*LC + LD*LD)/(2*LA*LC) - cos(TH2 - x);
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return -LD/LA*sin(x) - sin(TH2 - x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return x + f(x)/2;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 22 · Mecánica · Mecanismo de cuatro barras: ángulo del balancín (Freudenstein)

DESCRIPCION = 'f(t4) = d/a cos(t4) - d/c cos(t2) + (a^2 - b^2 + c^2 + d^2)/(2 a c) - cos(t2 - t4),  a = 40, b = 120, c = 80, d = 100, t2 = 60 grados'
DESCR_G = 'g(t4) = t4 + f(t4) / 2'

LA = 40.0   # manivela, mm
LB = 120.0   # acoplador, mm
LC = 80.0   # balancín, mm
LD = 100.0   # bancada, mm
TH2 = 1.0471975511965976   # ángulo de la manivela, rad (60 grados)

A, B = 0.5, 1.5   # intervalo de los métodos cerrados
X0 = 1.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return LD/LA*math.cos(x) - LD/LC*math.cos(TH2) + (LA*LA - LB*LB + LC*LC + LD*LD)/(2*LA*LC) - math.cos(TH2 - x)


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return -LD/LA*math.sin(x) - math.sin(TH2 - x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return x + f(x)/2

# =====================================================================
```

</details>

<a id="e23"></a>

### 23 · Primera frecuencia natural de una viga en voladizo

Las frecuencias de vibración de una viga empotrada en un extremo y libre en el otro salen de cos(βL) cosh(βL) + 1 = 0. La primera raíz, x = βL, da la frecuencia fundamental: ω₁ = x² √(EI/(mL⁴)).

| | |
|---|---|
| f(x) | f(x) = cos x cosh x + 1,  cosh x = (eˣ + e⁻ˣ)/2 |
| Despeje para punto fijo | g(x) = x + f(x)/4 |
| Intervalo [a, b] | [1, 3] |
| x₀ y δ | x₀ = 1.5 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 23 · Mecánica · Primera frecuencia natural de una viga en voladizo */

#define DESCRIPCION "f(x) = cos(x) cosh(x) + 1"
#define DESCR_G     "g(x) = x + f(x) / 4"


static const double A = 1.0, B = 3.0;  /* intervalo de los métodos cerrados */
static const double X0    = 1.5;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return cos(x)*(exp(x) + exp(-x))/2 + 1;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return -sin(x)*(exp(x) + exp(-x))/2 + cos(x)*(exp(x) - exp(-x))/2;
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return x + f(x)/4;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 23 · Mecánica · Primera frecuencia natural de una viga en voladizo

DESCRIPCION = 'f(x) = cos(x) cosh(x) + 1'
DESCR_G = 'g(x) = x + f(x) / 4'


A, B = 1.0, 3.0   # intervalo de los métodos cerrados
X0 = 1.5         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return math.cos(x)*(math.exp(x) + math.exp(-x))/2 + 1


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return -math.sin(x)*(math.exp(x) + math.exp(-x))/2 + math.cos(x)*(math.exp(x) - math.exp(-x))/2


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return x + f(x)/4

# =====================================================================
```

</details>

<a id="e24"></a>

### 24 · Carga que hace fluir una columna con carga excéntrica (fórmula de la secante)

Una columna de acero de 3 m (A = 4000 mm², radio de giro r = 40 mm, E = 200 GPa) recibe una carga P (kN) con excentricidad ec/r² = 0.25. Su esfuerzo máximo es σ = (P/A)(1 + (ec/r²) sec((L/2r)√(P/EA))). ¿Con qué P llega al esfuerzo de fluencia, 250 MPa? (P en kN: 1000P/A da MPa.)

| | |
|---|---|
| f(x) | f(P) = (1000P/A)(1 + (ec/r²) sec((L/(2r)) √(1000P/(EA)))) − σ_y |
| Despeje para punto fijo | g(P) = σ_y A / (1000 (1 + (ec/r²) sec((L/(2r)) √(1000P/(EA))))) |
| Intervalo [a, b] | [100, 1000] |
| x₀ y δ | x₀ = 500 · δ = 0.5 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 24 · Mecánica · Carga que hace fluir una columna con carga excéntrica (fórmula de la secante) */

#define DESCRIPCION "f(P) = 1000 P/A (1 + ec/r^2 sec(L/(2 r) sqrt(1000 P/(E A)))) - sy,  A = 4000, r = 40, L = 3000, E = 200000, sy = 250"
#define DESCR_G     "g(P) = sy A / (1000 (1 + ec/r^2 sec(L/(2 r) sqrt(1000 P/(E A)))))"

static const double AREA = 4000.0;   /* área, mm^2 */
static const double RGIR = 40.0;   /* radio de giro, mm */
static const double ECC = 0.25;   /* razón de excentricidad ec/r^2 */
static const double LONG = 3000.0;   /* longitud, mm */
static const double EMOD = 200000.0;   /* módulo de elasticidad, MPa */
static const double SIGY = 250.0;   /* esfuerzo de fluencia, MPa */

static const double A = 100.0, B = 1000.0;  /* intervalo de los métodos cerrados */
static const double X0    = 500.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.5;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return 1000*x/AREA*(1 + ECC/cos(LONG/(2*RGIR)*sqrt(1000*x/(EMOD*AREA)))) - SIGY;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return 1000/AREA*(1 + ECC/cos(LONG/(2*RGIR)*sqrt(1000*x/(EMOD*AREA))) + ECC*sin(LONG/(2*RGIR)*sqrt(1000*x/(EMOD*AREA)))*LONG/(2*RGIR)*sqrt(1000*x/(EMOD*AREA))/(2*cos(LONG/(2*RGIR)*sqrt(1000*x/(EMOD*AREA)))*cos(LONG/(2*RGIR)*sqrt(1000*x/(EMOD*AREA)))));
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return SIGY*AREA/(1000*(1 + ECC/cos(LONG/(2*RGIR)*sqrt(1000*x/(EMOD*AREA)))));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 24 · Mecánica · Carga que hace fluir una columna con carga excéntrica (fórmula de la secante)

DESCRIPCION = 'f(P) = 1000 P/A (1 + ec/r^2 sec(L/(2 r) sqrt(1000 P/(E A)))) - sy,  A = 4000, r = 40, L = 3000, E = 200000, sy = 250'
DESCR_G = 'g(P) = sy A / (1000 (1 + ec/r^2 sec(L/(2 r) sqrt(1000 P/(E A)))))'

AREA = 4000.0   # área, mm^2
RGIR = 40.0   # radio de giro, mm
ECC = 0.25   # razón de excentricidad ec/r^2
LONG = 3000.0   # longitud, mm
EMOD = 200000.0   # módulo de elasticidad, MPa
SIGY = 250.0   # esfuerzo de fluencia, MPa

A, B = 100.0, 1000.0   # intervalo de los métodos cerrados
X0 = 500.0         # inicio de los métodos abiertos
DELTA = 0.5      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return 1000*x/AREA*(1 + ECC/math.cos(LONG/(2*RGIR)*math.sqrt(1000*x/(EMOD*AREA)))) - SIGY


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return 1000/AREA*(1 + ECC/math.cos(LONG/(2*RGIR)*math.sqrt(1000*x/(EMOD*AREA))) + ECC*math.sin(LONG/(2*RGIR)*math.sqrt(1000*x/(EMOD*AREA)))*LONG/(2*RGIR)*math.sqrt(1000*x/(EMOD*AREA))/(2*math.cos(LONG/(2*RGIR)*math.sqrt(1000*x/(EMOD*AREA)))*math.cos(LONG/(2*RGIR)*math.sqrt(1000*x/(EMOD*AREA)))))


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return SIGY*AREA/(1000*(1 + ECC/math.cos(LONG/(2*RGIR)*math.sqrt(1000*x/(EMOD*AREA)))))

# =====================================================================
```

</details>

---

## Metalúrgica

<a id="e25"></a>

### 25 · Temperatura de una placa en un horno, con radiación y convección

Una placa de acero recibe 2000 W/m² dentro de un horno y pierde calor por convección (h = 15 W/m²K) y por radiación (ε = 0.9) hacia un ambiente a 298 K. ¿A qué temperatura T (K) se equilibra?

| | |
|---|---|
| f(x) | f(T) = εσ (T⁴ − 298⁴) + 15 (T − 298) − 2000,  ε = 0.9, σ = 5.67×10⁻⁸ |
| Despeje para punto fijo | g(T) = 298 + (2000 − εσ (T⁴ − 298⁴)) / 15 |
| Intervalo [a, b] | [300, 500] |
| x₀ y δ | x₀ = 350 · δ = 0.1 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 25 · Metalúrgica · Temperatura de una placa en un horno, con radiación y convección */

#define DESCRIPCION "f(T) = e s (T^4 - 298^4) + 15 (T - 298) - 2000,  e = 0.9, s = 5.67e-8"
#define DESCR_G     "g(T) = 298 + (2000 - e s (T^4 - 298^4)) / 15"

static const double EMIS = 0.9;   /* emisividad */
static const double SIGMA = 5.67e-08;   /* constante de Stefan-Boltzmann, W / (m^2 K^4) */
static const double TINF = 298.0;   /* temperatura del ambiente, K */
static const double HCONV = 15.0;   /* coeficiente de convección, W / (m^2 K) */
static const double QFLUJO = 2000.0;   /* flujo de calor que recibe, W / m^2 */

static const double A = 300.0, B = 500.0;  /* intervalo de los métodos cerrados */
static const double X0    = 350.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.1;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return EMIS*SIGMA*(x*x*x*x - TINF*TINF*TINF*TINF) + HCONV*(x - TINF) - QFLUJO;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return 4*EMIS*SIGMA*x*x*x + HCONV;
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return TINF + (QFLUJO - EMIS*SIGMA*(x*x*x*x - TINF*TINF*TINF*TINF))/HCONV;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 25 · Metalúrgica · Temperatura de una placa en un horno, con radiación y convección

DESCRIPCION = 'f(T) = e s (T^4 - 298^4) + 15 (T - 298) - 2000,  e = 0.9, s = 5.67e-8'
DESCR_G = 'g(T) = 298 + (2000 - e s (T^4 - 298^4)) / 15'

EMIS = 0.9   # emisividad
SIGMA = 5.67e-08   # constante de Stefan-Boltzmann, W / (m^2 K^4)
TINF = 298.0   # temperatura del ambiente, K
HCONV = 15.0   # coeficiente de convección, W / (m^2 K)
QFLUJO = 2000.0   # flujo de calor que recibe, W / m^2

A, B = 300.0, 500.0   # intervalo de los métodos cerrados
X0 = 350.0         # inicio de los métodos abiertos
DELTA = 0.1      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return EMIS*SIGMA*(x*x*x*x - TINF*TINF*TINF*TINF) + HCONV*(x - TINF) - QFLUJO


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return 4*EMIS*SIGMA*x*x*x + HCONV


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return TINF + (QFLUJO - EMIS*SIGMA*(x*x*x*x - TINF*TINF*TINF*TINF))/HCONV

# =====================================================================
```

</details>

<a id="e26"></a>

### 26 · Temperatura de ebullición del zinc en la Ciudad de México (585 mmHg)

Para refinar zinc por destilación importa a qué temperatura hierve. La presión de vapor del zinc líquido es log₁₀ p = 12.34 − 6620/T − 1.255 log₁₀ T (p en mmHg, T en K), y hierve cuando p iguala la presión del ambiente: 585 mmHg en la Ciudad de México.

| | |
|---|---|
| f(x) | f(T) = 12.34 − 6620/T − 1.255 log₁₀ T − log₁₀ 585 |
| Despeje para punto fijo | g(T) = 6620 / (12.34 − 1.255 log₁₀ T − log₁₀ 585) |
| Intervalo [a, b] | [900, 1400] |
| x₀ y δ | x₀ = 1000 · δ = 0.5 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 26 · Metalúrgica · Temperatura de ebullición del zinc en la Ciudad de México (585 mmHg) */

#define DESCRIPCION "f(T) = 12.34 - 6620/T - 1.255 log10(T) - log10(585)"
#define DESCR_G     "g(T) = 6620 / (12.34 - 1.255 log10(T) - log10(585))"

static const double AVAP = 12.34;   /* constantes de presión de vapor del zinc líquido */
static const double BVAP = 6620.0;
static const double CVAP = 1.255;
static const double PATM = 585.0;   /* presión del ambiente, mmHg */

static const double A = 900.0, B = 1400.0;  /* intervalo de los métodos cerrados */
static const double X0    = 1000.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.5;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return AVAP - BVAP/x - CVAP*log10(x) - log10(PATM);
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return BVAP/(x*x) - CVAP/(x*log(10));
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return BVAP/(AVAP - CVAP*log10(x) - log10(PATM));
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 26 · Metalúrgica · Temperatura de ebullición del zinc en la Ciudad de México (585 mmHg)

DESCRIPCION = 'f(T) = 12.34 - 6620/T - 1.255 log10(T) - log10(585)'
DESCR_G = 'g(T) = 6620 / (12.34 - 1.255 log10(T) - log10(585))'

AVAP = 12.34   # constantes de presión de vapor del zinc líquido
BVAP = 6620.0
CVAP = 1.255
PATM = 585.0   # presión del ambiente, mmHg

A, B = 900.0, 1400.0   # intervalo de los métodos cerrados
X0 = 1000.0         # inicio de los métodos abiertos
DELTA = 0.5      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return AVAP - BVAP/x - CVAP*math.log10(x) - math.log10(PATM)


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return BVAP/(x*x) - CVAP/(x*math.log(10))


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return BVAP/(AVAP - CVAP*math.log10(x) - math.log10(PATM))

# =====================================================================
```

</details>

<a id="e27"></a>

### 27 · Temple de una placa de acero: primer valor propio de la conducción transitoria

Al templar una placa, la temperatura de su centro se calcula con una serie cuyo primer término depende de λ₁, la primera raíz de λ tan λ = Bi. La placa tiene número de Biot Bi = hL/k = 2.

| | |
|---|---|
| f(x) | f(λ) = λ sen λ − Bi cos λ,  Bi = 2 |
| Despeje para punto fijo | g(λ) = Bi cos λ / sen λ |
| Intervalo [a, b] | [0.1, 1.5] |
| x₀ y δ | x₀ = 1 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 27 · Metalúrgica · Temple de una placa de acero: primer valor propio de la conducción transitoria */

#define DESCRIPCION "f(l) = l sin(l) - Bi cos(l),  Bi = 2"
#define DESCR_G     "g(l) = Bi cos(l) / sin(l)"

static const double BIOT = 2.0;   /* número de Biot, hL/k */

static const double A = 0.1, B = 1.5;  /* intervalo de los métodos cerrados */
static const double X0    = 1.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return x*sin(x) - BIOT*cos(x);
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return sin(x) + x*cos(x) + BIOT*sin(x);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return BIOT*cos(x)/sin(x);
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 27 · Metalúrgica · Temple de una placa de acero: primer valor propio de la conducción transitoria

DESCRIPCION = 'f(l) = l sin(l) - Bi cos(l),  Bi = 2'
DESCR_G = 'g(l) = Bi cos(l) / sin(l)'

BIOT = 2.0   # número de Biot, hL/k

A, B = 0.1, 1.5   # intervalo de los métodos cerrados
X0 = 1.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return x*math.sin(x) - BIOT*math.cos(x)


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return math.sin(x) + x*math.cos(x) + BIOT*math.sin(x)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return BIOT*math.cos(x)/math.sin(x)

# =====================================================================
```

</details>

---

## Química

<a id="e28"></a>

### 28 · Volumen molar del CO₂ (Van der Waals), p = 10 atm, T = 300 K

A presión alta el CO₂ deja de comportarse como gas ideal. Con la ecuación de Van der Waals, ¿qué volumen molar v (L/mol) ocupa a 10 atm y 300 K?

| | |
|---|---|
| f(x) | f(v) = (p + a/v²)(v − b) − RT,  a = 3.592, b = 0.04267, R = 0.082054 |
| Despeje para punto fijo | g(v) = RT / (p + a/v²) + b |
| Intervalo [a, b] | [1, 4] |
| x₀ y δ | x₀ = 2 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 28 · Química · Volumen molar del CO₂ (Van der Waals), p = 10 atm, T = 300 K */

#define DESCRIPCION "f(v) = (p + a/v^2)(v - b) - R T,  p = 10, T = 300, a = 3.592, b = 0.04267, R = 0.082054"
#define DESCR_G     "g(v) = R T / (p + a/v^2) + b"

static const double PRES = 10.0;   /* presión, atm */
static const double TEMP = 300.0;   /* temperatura, K */
static const double AVDW = 3.592;   /* constante a del CO2, L^2 atm / mol^2 */
static const double BVDW = 0.04267;   /* constante b del CO2, L / mol */
static const double RGAS = 0.082054;   /* constante de los gases, L atm / (mol K) */

static const double A = 1.0, B = 4.0;  /* intervalo de los métodos cerrados */
static const double X0    = 2.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return (PRES + AVDW / (x*x)) * (x - BVDW) - RGAS*TEMP;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return (PRES + AVDW / (x*x)) - 2*AVDW / (x*x*x) * (x - BVDW);
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return RGAS*TEMP / (PRES + AVDW / (x*x)) + BVDW;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 28 · Química · Volumen molar del CO₂ (Van der Waals), p = 10 atm, T = 300 K

DESCRIPCION = 'f(v) = (p + a/v^2)(v - b) - R T,  p = 10, T = 300, a = 3.592, b = 0.04267, R = 0.082054'
DESCR_G = 'g(v) = R T / (p + a/v^2) + b'

PRES = 10.0   # presión, atm
TEMP = 300.0   # temperatura, K
AVDW = 3.592   # constante a del CO2, L^2 atm / mol^2
BVDW = 0.04267   # constante b del CO2, L / mol
RGAS = 0.082054   # constante de los gases, L atm / (mol K)

A, B = 1.0, 4.0   # intervalo de los métodos cerrados
X0 = 2.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return (PRES + AVDW / (x*x)) * (x - BVDW) - RGAS*TEMP


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return (PRES + AVDW / (x*x)) - 2*AVDW / (x*x*x) * (x - BVDW)


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return RGAS*TEMP / (PRES + AVDW / (x*x)) + BVDW

# =====================================================================
```

</details>

<a id="e29"></a>

### 29 · Avance de la reacción 2A + B ⇌ C en el equilibrio

En un reactor por lotes, la reacción 2A + B ⇌ C llega al equilibrio con K = c_C/(c_A² c_B) = 0.016. Se empieza con c_A0 = 42, c_B0 = 28 y c_C0 = 4 mol/L; si se forman x mol/L de C, quedan c_A = 42 − 2x, c_B = 28 − x y c_C = 4 + x. ¿Cuánto vale x?

| | |
|---|---|
| f(x) | f(x) = (4 + x) / ((42 − 2x)² (28 − x)) − 0.016 |
| Despeje para punto fijo | g(x) = (42 − √((4 + x) / (0.016 (28 − x)))) / 2 |
| Intervalo [a, b] | [5, 18] |
| x₀ y δ | x₀ = 13 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 29 · Química · Avance de la reacción 2A + B ⇌ C en el equilibrio */

#define DESCRIPCION "f(x) = (cc0 + x) / ((ca0 - 2x)^2 (cb0 - x)) - K,  K = 0.016, ca0 = 42, cb0 = 28, cc0 = 4"
#define DESCR_G     "g(x) = (ca0 - sqrt((cc0 + x) / (K (cb0 - x)))) / 2"

static const double KEQ = 0.016;   /* constante de equilibrio */
static const double CA0 = 42.0;   /* concentración inicial de A, mol/L */
static const double CB0 = 28.0;   /* concentración inicial de B, mol/L */
static const double CC0 = 4.0;   /* concentración inicial de C, mol/L */

static const double A = 5.0, B = 18.0;  /* intervalo de los métodos cerrados */
static const double X0    = 13.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return (CC0 + x)/((CA0 - 2*x)*(CA0 - 2*x)*(CB0 - x)) - KEQ;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return 1/((CA0 - 2*x)*(CA0 - 2*x)*(CB0 - x)) + (CC0 + x)*(4*(CB0 - x) + (CA0 - 2*x))/((CA0 - 2*x)*(CA0 - 2*x)*(CA0 - 2*x)*(CB0 - x)*(CB0 - x));
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return (CA0 - sqrt((CC0 + x)/(KEQ*(CB0 - x))))/2;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 29 · Química · Avance de la reacción 2A + B ⇌ C en el equilibrio

DESCRIPCION = 'f(x) = (cc0 + x) / ((ca0 - 2x)^2 (cb0 - x)) - K,  K = 0.016, ca0 = 42, cb0 = 28, cc0 = 4'
DESCR_G = 'g(x) = (ca0 - sqrt((cc0 + x) / (K (cb0 - x)))) / 2'

KEQ = 0.016   # constante de equilibrio
CA0 = 42.0   # concentración inicial de A, mol/L
CB0 = 28.0   # concentración inicial de B, mol/L
CC0 = 4.0   # concentración inicial de C, mol/L

A, B = 5.0, 18.0   # intervalo de los métodos cerrados
X0 = 13.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return (CC0 + x)/((CA0 - 2*x)*(CA0 - 2*x)*(CB0 - x)) - KEQ


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return 1/((CA0 - 2*x)*(CA0 - 2*x)*(CB0 - x)) + (CC0 + x)*(4*(CB0 - x) + (CA0 - 2*x))/((CA0 - 2*x)*(CA0 - 2*x)*(CA0 - 2*x)*(CB0 - x)*(CB0 - x))


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return (CA0 - math.sqrt((CC0 + x)/(KEQ*(CB0 - x))))/2

# =====================================================================
```

</details>

<a id="e30"></a>

### 30 · Temperatura de burbuja de una mezcla benceno-tolueno a 585 mmHg

Una mezcla líquida con 40 % de benceno y 60 % de tolueno (fracción mol) se calienta en la Ciudad de México, a 585 mmHg. Empieza a hervir a la temperatura T (°C) en la que la suma de las presiones parciales (ley de Raoult) iguala la del ambiente. Presiones de vapor con la ecuación de Antoine, log₁₀ p = A − B/(T + C), en mmHg.

| | |
|---|---|
| f(x) | f(T) = 0.4 p_B(T) + 0.6 p_T(T) − 585,  p(T) = 10^(A − B/(T + C)) |
| Despeje para punto fijo | g(T) = B_B / (A_B − log₁₀((585 − 0.6 p_T(T)) / 0.4)) − C_B |
| Intervalo [a, b] | [60, 110] |
| x₀ y δ | x₀ = 80 · δ = 0.01 |

<details><summary>Bloque para <code>raices.c</code></summary>

```c
/* ======================== BLOQUE DEL PROBLEMA ======================== */
/* Ecuación 30 · Química · Temperatura de burbuja de una mezcla benceno-tolueno a 585 mmHg */

#define DESCRIPCION "f(T) = x pB(T) + (1 - x) pT(T) - P,  p = 10^(A - B/(T + C)),  x = 0.4, P = 585"
#define DESCR_G     "g(T) = BB / (AB - log10((P - (1 - x) pT(T)) / x)) - CB"

static const double XBEN = 0.4;   /* fracción mol de benceno */
static const double PTOT = 585.0;   /* presión, mmHg */
static const double AB = 6.90565;   /* Antoine del benceno: A, B, C */
static const double BB = 1211.033;
static const double CB = 220.79;
static const double AT = 6.95464;   /* Antoine del tolueno: A, B, C */
static const double BT = 1344.8;
static const double CT = 219.482;

static const double A = 60.0, B = 110.0;  /* intervalo de los métodos cerrados */
static const double X0    = 80.0;        /* inicio de los métodos abiertos    */
static const double DELTA = 0.01;        /* incremento de la secante modificada */
static const double TOL   = 0.5;         /* tolerancia: ea en %               */
#define NMAX 50                          /* máximo de iteraciones             */

static double f(double x)
{
    return XBEN*exp((AB - BB/(x + CB))*log(10)) + (1 - XBEN)*exp((AT - BT/(x + CT))*log(10)) - PTOT;
}

/* Su derivada, para Newton-Raphson. */
static double fp(double x)
{
    return XBEN*exp((AB - BB/(x + CB))*log(10))*log(10)*BB/((x + CB)*(x + CB)) + (1 - XBEN)*exp((AT - BT/(x + CT))*log(10))*log(10)*BT/((x + CT)*(x + CT));
}

/* Despeje x = g(x) para punto fijo. */
static double g(double x)
{
    return BB/(AB - log10((PTOT - (1 - XBEN)*exp((AT - BT/(x + CT))*log(10)))/XBEN)) - CB;
}

/* ===================================================================== */
```

</details>

<details><summary>Bloque para <code>raices.py</code></summary>

```python
# ======================== BLOQUE DEL PROBLEMA ========================
# Ecuación 30 · Química · Temperatura de burbuja de una mezcla benceno-tolueno a 585 mmHg

DESCRIPCION = 'f(T) = x pB(T) + (1 - x) pT(T) - P,  p = 10^(A - B/(T + C)),  x = 0.4, P = 585'
DESCR_G = 'g(T) = BB / (AB - log10((P - (1 - x) pT(T)) / x)) - CB'

XBEN = 0.4   # fracción mol de benceno
PTOT = 585.0   # presión, mmHg
AB = 6.90565   # Antoine del benceno: A, B, C
BB = 1211.033
CB = 220.79
AT = 6.95464   # Antoine del tolueno: A, B, C
BT = 1344.8
CT = 219.482

A, B = 60.0, 110.0   # intervalo de los métodos cerrados
X0 = 80.0         # inicio de los métodos abiertos
DELTA = 0.01      # incremento de la secante modificada
TOL = 0.5           # tolerancia: ea en %
NMAX = 50           # máximo de iteraciones


def f(x):
    """La función cuya raíz se busca."""
    return XBEN*math.exp((AB - BB/(x + CB))*math.log(10)) + (1 - XBEN)*math.exp((AT - BT/(x + CT))*math.log(10)) - PTOT


def fp(x):
    """Su derivada, para Newton-Raphson."""
    return XBEN*math.exp((AB - BB/(x + CB))*math.log(10))*math.log(10)*BB/((x + CB)*(x + CB)) + (1 - XBEN)*math.exp((AT - BT/(x + CT))*math.log(10))*math.log(10)*BT/((x + CT)*(x + CT))


def g(x):
    """Despeje x = g(x) para punto fijo."""
    return BB/(AB - math.log10((PTOT - (1 - XBEN)*math.exp((AT - BT/(x + CT))*math.log(10)))/XBEN)) - CB

# =====================================================================
```

</details>
