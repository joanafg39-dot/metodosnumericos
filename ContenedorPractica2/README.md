# Entorno del curso · Métodos Numéricos en Ingeniería (1151039)

Trimestre 26-O · UAM Azcapotzalco · División de Ciencias Básicas e Ingeniería

Todo el curso se programa, se ejecuta y se califica dentro de este contenedor.
No hace falta instalar Octave, un compilador de C ni Python en la computadora:
lo único que se instala es Docker.

---

> ### 🧪 Esta carpeta trae la Práctica 2
> Los programas están en [`practica2/`](practica2/). Cómo se corre cada uno, paso a paso:
> [`practica2/COMO_CORRER.md`](practica2/COMO_CORRER.md). El reporte se escribe en
> [`practica2/README.md`](practica2/README.md), y la ecuación de cada equipo está en
> [`practica2/ECUACIONES.md`](practica2/ECUACIONES.md).
>
> **Se trabaja en el repositorio del equipo de la Práctica 1.** Como ese repositorio ya
> tiene `compose.yaml` y `Dockerfile` en la raíz, basta copiarle la carpeta `practica2/`.
> El resto de esta carpeta es el mismo entorno del curso, por si hiciera falta.

> ### 👋 ¿Es tu primera vez?
> **Empieza por [`EMPIEZA_AQUI.md`](EMPIEZA_AQUI.md)**, que te lleva paso a paso.
> Y ten a mano [`COMANDOS.md`](COMANDOS.md), que es la hoja de comandos para imprimir.
> Este documento es para después.


> **Comprobado el 21 de septiembre de 2026** con Docker 29.6.2 y Compose v5.3.1: la
> imagen construye, las tres herramientas responden y las tres dan el mismo resultado.

## Qué archivos hacen falta

**El mínimo para levantar el entorno son dos archivos.** Comprobado: se construye y
funciona.

| Archivo | Qué es | ¿Obligatorio? |
|---|---|---|
| `Dockerfile` | Qué lleva dentro la imagen. **14 instrucciones.** | **Sí** |
| `compose.yaml` | Cómo se usa. **13 líneas.** | **Sí** |
| `.dockerignore` | Evita mandar todo el repositorio al construir | No, pero acelera |
| `extras/comprobar.sh` | Comprueba que las tres herramientas dan lo mismo | No |
| `extras/ejemplos/` | Los tres programas de esa comprobación | No |
| `README.md`, `docker_tutorial.md` | Documentación | No |

Los dos obligatorios son del tamaño de un `compose.yaml` de PostgreSQL. La explicación
de cada línea **no está dentro de los archivos**, está en `docker_tutorial.md`, que es
donde se lee una vez y no estorba el resto del semestre.

---

## Qué trae dentro

| Herramienta | Para qué se usa en el curso |
|---|---|
| **GNU Octave 7.3** | Prototipar el método. Compatible con los guiones de MATLAB. |
| **gcc / g++ 12** | Implementarlo. El programa de estudios pide al menos una implementación en C. |
| **gdb** | Depurar el programa de C cuando un método diverge. |
| **Python 3.11** | Verificar el resultado y generar las figuras del reporte. |
| **NumPy · SciPy** | Las rutinas de referencia contra las que se compara el método propio. |
| **Matplotlib** | Las gráficas de convergencia y de error. |
| **SymPy** | La solución analítica con la que se compara el método numérico. |
| **Git y nano** | Para versionar o editar un archivo sin salir del contenedor. |

¿Hace falta algo más adelante? Se añade a la lista del `RUN` del `Dockerfile` y se
reconstruye con `docker compose up -d --build`. Son dos minutos.

Las versiones están **fijadas**. Ésa es la razón de ser del contenedor: que la
tabla que sale en la computadora del equipo sea exactamente la misma que sale al
calificar.

---

## Dónde van estos archivos

**En la raíz del repositorio del equipo**, junto a las prácticas:

```
repositorio-del-equipo/          ← aquí se abre la terminal
  Dockerfile
  compose.yaml
  .dockerignore
  .gitignore
  LICENSE
  README.md
  tarea1/
  practica1/
  practica2/
    raices.c   raices.m   raices.py
    README.md   COMO_CORRER.md   ECUACIONES.md
    img/
```

El `compose.yaml` monta **esta misma carpeta** dentro del contenedor, en `/trabajo`.
La consecuencia es la que hace que todo encaje:

```
Windows                              Dentro del contenedor
─────────────────────────            ─────────────────────────
repositorio-del-equipo/        ═══►  /trabajo/
  Dockerfile                           Dockerfile
  compose.yaml                         compose.yaml
  tarea1/                              tarea1/
  practica1/                           practica1/
  practica2/                           practica2/
```

**`ls` dentro del contenedor muestra exactamente lo mismo que el Explorador de
Windows.** Si muestra otra cosa, es que la terminal se abrió en otra carpeta.

Y sólo esa carpeta: el contenedor no ve el resto del disco. Ésa es la única ventana que
se abre, y se abre a propósito.

---

## Puesta en marcha

### 1 · Instalar Docker

- **Windows y macOS**: Docker Desktop, de `docker.com/products/docker-desktop`.
  En Windows hace falta tener la virtualización habilitada en el BIOS.
- **Linux**: el paquete `docker.io` más `docker-compose-plugin` de la
  distribución, o el repositorio oficial de Docker.

Comprobar que quedó bien:

```bash
docker --version
docker run hello-world
```

### 2 · Construir y prender

Desde esta carpeta. La primera vez tarda entre cinco y quince minutos, porque
descarga y construye la imagen; a partir de ahí es cuestión de segundos.

```bash
cd Contenedor
docker compose up -d --build
```

`up -d` prende el contenedor y lo deja corriendo en segundo plano. `--build`
construye la imagen antes; sólo hace falta la primera vez y cuando se cambie el
`Dockerfile`.

### 3 · Comprobar que el entorno quedó bien

```bash
docker compose up -d
docker compose exec metodos bash extras/comprobar.sh
```

Ejecuta el mismo cálculo —√2 por el método babilónico— en Octave, en C y en
Python, y comprueba que los tres dan **1.414213562375**. Si coinciden, el
entorno está listo.

---

## Los tres comandos. No hay más.

Todos se ejecutan desde esta carpeta, en la terminal de Windows.

```bash
docker compose up -d                 # 1 · PRENDER el contenedor
docker compose exec metodos bash     # 2 · ENTRAR a trabajar
docker compose stop                  # 3 · APAGARLO al terminar
```

Es exactamente el mismo esquema que el contenedor de PostgreSQL de Bases de Datos:

| | PostgreSQL (Bases de Datos) | Este entorno |
|---|---|---|
| **Prender** | `docker compose up -d` | `docker compose up -d` |
| **Entrar** | `docker compose exec postgres psql -U postgres` | `docker compose exec metodos bash` |
| **Apagar** | `docker compose stop` | `docker compose stop` |
| **Qué corre dentro** | Una base de datos | Octave, gcc y Python |

Una vez dentro se ve un prompt como `root@a20d7ab8:/trabajo#`, y a partir de ahí se
trabaja normal:

```bash
cd practica2
octave raices.m
python3 raices.py
gcc -O2 -std=c17 -Wall -o raices raices.c -lm && ./raices
```

Para salir del contenedor sin apagarlo: `exit`. El contenedor sigue prendido y se puede
volver a entrar con `exec` cuantas veces haga falta. Para apagarlo: `docker compose stop`.

> **Aviso:** `docker`, `git` y los programas de Windows **no existen dentro del
> contenedor**. Si se escribe `docker compose down` estando dentro, sale
> `bash: docker: command not found`, y está bien que así sea: es la prueba de que el
> contenedor está aislado. Los comandos de Docker se escriben **fuera**, en la terminal
> de Windows.

### `stop` y `down` no son lo mismo

Es la primera sorpresa que se lleva todo el mundo: **`down` borra el contenedor** y
desaparece de la pestaña *Containers* de Docker Desktop.

| Comando | Qué le pasa al contenedor | ¿Sigue en Docker Desktop? | ¿Y mis archivos? |
|---|---|---|---|
| `docker compose stop` | Se **apaga**. Es el interruptor de la luz. | Sí, apagado | Intactos |
| `docker compose start` | Se vuelve a prender, el mismo de antes. | Sí, encendido | Intactos |
| `docker compose down` | Se apaga **y se borra**. | No, desaparece | Intactos |
| `docker compose down -v` | Se apaga y se borra, y además se borran los **volúmenes con nombre**. | No | Intactos |

**Ninguno de los cuatro borra tu trabajo**, y conviene entender por qué: los archivos no
viven dentro del contenedor, viven en esta carpeta de Windows. El contenedor sólo la mira
a través del volumen.

Sobre `-v`: en este entorno **no hace absolutamente nada extra**, porque aquí no hay
volúmenes con nombre. La línea `./:/trabajo` del compose es un *bind mount* —una carpeta
real tuya— y a ésos `-v` no los toca nunca. La regla corta:

- Si en el compose la ruta empieza por `.` o por `/` → es una carpeta tuya. `-v` no la toca.
- Si es un nombre a secas, como `pg_datos:` → es un volumen de Docker. `-v` sí lo borra.

Para el día a día, `stop` y `start`. `down` cuando se quiera dejar limpio, o después de
cambiar el `Dockerfile`. La imagen construida sobrevive a todos ellos, así que volver a
prender tarda dos segundos.

> **Sólo hay que reconstruir** —`docker compose up -d --build`— cuando se cambie el
> `Dockerfile`. El resto del trimestre, `up -d` a secas.

---

## Los cuatro conceptos, aplicados a esta carpeta

| Concepto | Dónde está aquí |
|---|---|
| **Imagen** | `metodos-1151039:26o`. La plantilla ya construida. Se hace una vez. |
| **Contenedor** | `metodos_practica2`. El que se prende con `up -d` y se apaga con `stop`. |
| **Volumen** | `./:/trabajo`. Esta carpeta, vista desde dentro. Lo único del disco que el contenedor ve. |
| **Puerto** | No se usa. Este entorno no publica ningún puerto porque no corre ningún servidor. |

---

## Qué falla y cómo se diagnostica

Antes de borrar todo y volver a empezar, **lea el mensaje de error**: casi
siempre lo dice con todas sus letras.

| Síntoma | Casi siempre es | Qué hacer |
|---|---|---|
| `Cannot connect to the Docker daemon` | Docker Desktop no está abierto | Abrirlo; en Linux, `sudo systemctl start docker` |
| La terminal se queda colgada sin devolver el prompt | Se usó `up` sin `-d`, y quedó enganchada a la salida del contenedor | Ctrl+C, y después `docker compose up -d` |
| `service "metodos" is not running` al hacer `exec` | El contenedor está apagado | `docker compose up -d` primero |
| `bash: docker: command not found` | Se escribió un comando de Docker **dentro** del contenedor | `exit` primero, y escribirlo en la terminal de Windows |
| `ls` muestra archivos que no esperaba | La terminal se abrió en otra carpeta | `cd` a la carpeta del `compose.yaml` y volver a prender |
| El contenedor arranca y se cierra | Falta `stdin_open`/`tty`, o el comando terminó | `docker compose logs` y leer la última línea |
| `permission denied` al escribir (Linux) | El contenedor escribe como root | Añadir `user: "${UID}:${GID}"` al servicio |
| La figura no aparece en la carpeta | Se guardó fuera del volumen | Guardar dentro de `/trabajo`, no en `/tmp` |
| `externally-managed-environment` al usar pip | Debian protege su Python del sistema | Ver el anexo A.8 del tutorial: hace falta un entorno virtual |
| La construcción tarda muchísimo | Se está mandando todo el repositorio | Comprobar que existe el `.dockerignore` |

Los dos comandos con los que empieza cualquier diagnóstico:

```bash
docker compose ps        # ¿está encendido, apagado, o nunca arrancó?
docker compose logs      # ¿qué dijo antes de morir?
```

---

## Cómo se le añade algo

**Casi todo se añade en la misma línea**: a la lista del `RUN` del `Dockerfile`, y se
reconstruye con `docker compose up -d --build`. Por ejemplo:

- `python3-pandas \` para tablas de datos
- `octave-statistics \` para el paquete de estadística de Octave
- `valgrind \` para detectar accesos inválidos de memoria en C

**Si la biblioteca de Python no existe como paquete de Debian**, hace falta un entorno
virtual dentro de la imagen. Está explicado en el anexo A.8 del tutorial.

Cualquiera de los dos cambios se documenta en el reporte de la práctica que lo
necesitó, y entra al repositorio por Pull Request como cualquier otro cambio.

---

## Reglas de entrega relacionadas

1. El `Dockerfile` y el `compose.yaml` **van versionados** en el repositorio.
   Son parte de la entrega, no un accesorio.
2. Las versiones van **fijadas**. `latest` no se acepta.
3. Los resultados del reporte se generan **dentro del contenedor**. Un número
   obtenido en otro entorno no es reproducible y no se califica como tal.
4. Nada de credenciales, ni archivos `.env`, ni binarios compilados dentro del
   repositorio: para eso está el `.gitignore`.

---

*M. en C. Gabriel Hurtado Avilés · UEA 1151039 · Trimestre 26-O*
