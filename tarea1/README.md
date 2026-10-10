# Tarea 1 - Métodos Numéricos

**Unidad de Enseñanza-Aprendizaje:** Métodos Numéricos en Ingeniería (1151039)  
**Trimestre:** 26-O  
**Licenciatura:** Ingeniería en Mecanica 
**Nombre del Alumno:** Joana Flores Gutierrez 
**Matrícula:** 2253078289  
**Profesor:** [Nombre de tu Profesor]  
**Fecha:** 9/10/2026 

---

## Ejercicio 2. El README

### 1. ¿Qué son los métodos numéricos?
Definición: Los métodos numéricos son formulaciones relativas a problemas matemáticos que se resuelven mediante operaciones aritméticas aproximadas. Se expresan en forma de algoritmos iterativos diseñados para ejecutarse en computadoras y resolver ecuaciones complejas de ingeniería.

Diferencia con la solución analítica: Una solución analítica otorga una respuesta exacta en forma de función o valor cerrado a través de reglas matemáticas puras. En cambio, una solución numérica ofrece una estimación cuantitativa aproximada de la respuesta real mediante una serie finita de pasos aritméticos.

Papel del error: El error desempeña un papel central en los métodos numéricos porque la mayoría de las soluciones numéricas son aproximadas. Conocer y cuantificar el error (verdadero, relativo o por truncamiento/redondeo) permite determinar la precisión, controlar la convergencia del algoritmo y garantizar que el resultado sea numéricamente confiable para su aplicación práctica.

### 2. ¿Cómo se aplican en su ingeniería?
En Ingeniería Mecánica, los métodos numéricos son fundamentales para analizar y resolver problemas físicos que no admiten soluciones analíticas exactas debido a geometrías complejas o no linealidades del material:

Análisis de transferencia de calor y distribución de temperatura: Para diseñar componentes expuestos a altas temperaturas (como álabes de turbinas, bloques de motor o Intercambiadores de calor), se resuelven numéricamente ecuaciones parciales de conducción térmica utilizando diferencias finitas o elementos finitos para obtener el mapa de temperaturas en todo el sólido.

Simulación de esfuerzo y deformación estructural (FEA): En el diseño de chasis, estructuras y elementos mecánicos sometidos a cargas, se divide la pieza en una malla de elementos discretos para resolver sistemas algebraicos matriciales de gran tamaño, identificando puntos de concentración de esfuerzos antes de fabricar un prototipo físico.

### 3. ¿Qué herramientas se usan para trabajar con métodos numéricos?
Lenguajes compilados (C / C++): Ofrecen alta velocidad de ejecución y gestión eficiente de la memoria a bajo nivel, siendo ideales para la implementación de algoritmos pesados y de alto rendimiento.

Entornos matriciales (GNU Octave / MATLAB): Orientados al cálculo vectorial y matricial, facilitan el prototipado rápido de algoritmos, la solución de sistemas de ecuaciones y la visualización gráfica de resultados.

Lenguajes interpretados y librerías científicas (Python con NumPy, SciPy y Matplotlib): Proporcionan un balance entre sintaxis sencilla, bibliotecas científicas de alto nivel y potentes capacidades de procesamiento de datos.

### 4. ¿Qué herramientas usamos en este curso?
Docker y contenedores: Docker nos permite aislar el entorno de trabajo (compiladores, bibliotecas e intérpretes) para garantizar reproducibilidad exacta en cualquier equipo sin importar el sistema operativo anfitrión. A diferencia de una máquina virtual, Docker comparte el núcleo del sistema operativo, requiriendo muchísimos menos recursos.

Comandos y administración de contenedores: Se utilizan comandos como docker compose up -d para levantar el entorno en segundo plano y docker exec -it <contenedor> bash para abrir la consola interactiva. Detener un contenedor (stop) pausa su ejecución manteniendo su estado, mientras que borrarlo (down) destruye los recursos y la red asociada.

Ecosistema del curso (GCC, Python3, GNU Octave): Se cuenta con un contenedor unificado que integra el compilador gcc para C, el intérprete python3 y octave para scripts .m.


## Ejercicio 3. Capturas del entorno corriendo

![docker compose up](img/01-started.png)
![docker compose ps](img/02-ps.png)
![versiones en contenedor](img/03-versiones.png)
![Docker Desktop](img/04-docker-desktop.png)
![programas ejecutándose](img/05-programas.png)


## Ejercicio 4. Dos programas

### 1. Programa Suma de dos números
[Explicación de la precisión de punto flotante: ¿Por qué 0.1 + 0.2 no da exactamente 0.3 y si los tres lenguajes coinciden?].

### 2. Calculadora Básica
[Tabla de casos de prueba que incluya la división entre cero y entradas no numéricas].


## Referencias
Chapra, S. C., & Canale, R. P. (2015). Métodos numéricos para ingenieros (7a ed.). McGraw-Hill Education.

Burden, R. L., Faires, J. D., & Burden, A. M. (2017). Análisis numérico (10a ed.). Cengage Learning.

Universidad Autónoma Metropolitana. (2026). Planeación didáctica: Métodos Numéricos en Ingeniería (UEA 1151039). UAM Azcapotzalco, División de Ciencias Básicas e Ingeniería.