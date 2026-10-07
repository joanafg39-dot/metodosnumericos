# 👋 Empieza aquí

**UEA 1151039 · Métodos Numéricos en Ingeniería · 26-O · UAM Azcapotzalco**

Esta guía te lleva de la mano en tu **primera sesión**. Son siete pasos. En cada uno te
digo qué escribir, **qué debe salir en pantalla**, y qué hacer si sale otra cosa.

No hace falta saber nada de Docker para seguirla. Cuando termines, tendrás el entorno del
curso funcionando y sabrás los tres comandos que usarás todo el trimestre.

> **Tiempo:** unos 30 minutos la primera vez. Después, 10 segundos cada día.

---

## Antes de empezar: ¿qué es esto y por qué?

En este curso vas a programar en **tres herramientas**: Octave, C y Python. Instalarlas
una por una en tu computadora es lento, y cada quien acabaría con versiones distintas: tu
programa daría un número y el de tu compañera otro.

Para evitarlo usamos **Docker**, que instala las tres de golpe, **exactamente iguales**
en todas las computadoras del grupo. Es como recibir una caja cerrada con el taller ya
montado dentro: tú no instalas nada, sólo abres la caja.

Sólo necesitas instalar **una cosa**: Docker. Todo lo demás viene dentro.

---

## Paso 1 · Instalar Docker Desktop

### Si tienes Windows

1. Entra a <https://www.docker.com/products/docker-desktop>
2. Pulsa **Download for Windows**
3. Ejecuta el instalador como administrador
4. Deja marcada la casilla **«Use WSL 2»**
5. **Reinicia la computadora** cuando te lo pida

### Si tienes Mac

Lo mismo, pero pulsa **Download for Mac**. Hay **dos descargas distintas**: una para
Intel y otra para Apple Silicon (los Mac de 2020 en adelante). Si eliges mal, no
funciona. Para saber cuál tienes: menú  → *Acerca de esta Mac*.

### Si tienes Linux

```bash
sudo apt update
sudo apt install -y docker.io docker-compose-plugin
sudo usermod -aG docker $USER
newgrp docker
```

---

## Paso 2 · Abrir Docker Desktop

**Ábrelo y déjalo abierto.** Este paso parece tonto y es el que más problemas causa:

> Si Docker Desktop está cerrado, **ningún comando de esta guía funciona**. Sale
> `Cannot connect to the Docker daemon` y parece que todo está roto.

Espera a que el icono de la ballena 🐳 deje de moverse. Cuando está quieto, está listo.

---

## Paso 3 · Abrir la terminal en la carpeta correcta

Aquí se atasca mucha gente, así que con detalle.

Necesitas una terminal **abierta justo en la carpeta donde está el archivo
`compose.yaml`**. En Windows, la forma más fácil:

1. Abre el **Explorador de archivos** y entra a la carpeta del curso (la que tiene
   `Dockerfile` y `compose.yaml`).
2. Haz clic en la **barra de direcciones** de arriba, borra lo que dice y escribe:

   ```
   cmd
   ```

3. Pulsa **Enter**.

Se abre una ventana negra que ya está en esa carpeta. Debe verse así, con **tu** ruta:

```
C:\Users\tuusuario\...\Contenedor>
```

> **Otra forma:** `Shift` + clic derecho en un hueco de la carpeta → *«Abrir ventana de
> PowerShell aquí»*.

> **Si sale `no configuration file provided`** más adelante, es que la terminal no está
> en la carpeta correcta. Vuelve a este paso.

---

## Paso 4 · Comprobar que Docker responde

Escribe:

```bash
docker --version
```

Debe salir algo parecido a esto (el número puede ser otro):

```
Docker version 29.8.0, build 88096ef
```

Y después:

```bash
docker compose version
```

```
Docker Compose version v5.5.1
```

**¿Salió `Cannot connect to the Docker daemon`?** Docker Desktop está cerrado. Vuelve al
paso 2.

> Fíjate: es **`docker compose`, con espacio**. Verás por internet `docker-compose` con
> guion: ésa es la versión vieja. Usa la del espacio.

---

## Paso 5 · Construir y prender el entorno

Esto sólo se hace **una vez**. Escribe:

```bash
docker compose up -d --build
```

Y ahora **espera**. Van a salir decenas de líneas y va a tardar **entre 5 y 15 minutos**,
porque está descargando Linux y instalando Octave, el compilador de C y Python. Es
normal. No lo interrumpas.

Cuando acabe, las últimas líneas se ven así:

```
 ✔ Image metodos-1151039:26o    Built
 ✔ Container metodos_practica2    Started
```

**Ese `Started` es la señal de que funcionó.** Ya tienes el entorno prendido.

Compruébalo:

```bash
docker compose ps
```

```
NAME              IMAGE                 COMMAND   SERVICE   STATUS
metodos_practica2   metodos-1151039:26o   "bash"    metodos   Up 1 second
```

`Up` quiere decir «encendido».

> **¿La terminal se quedó colgada diciendo `Attaching to metodos_practica2`?**
> Se te olvidó la `-d`. Pulsa `Ctrl + C` y vuelve a escribir el comando **con** `-d`.

---

## Paso 6 · Entrar a trabajar

```bash
docker compose exec metodos bash
```

El prompt cambia y se ve así (las letras y números serán otros):

```
root@a8eacd2c7937:/trabajo#
```

**Ya estás dentro del contenedor.** Eso es Linux, corriendo dentro de tu Windows.

Prueba estas tres cosas:

```bash
ls
```

Te muestra los archivos de tu carpeta. **Son los mismos que ves en el Explorador de
Windows** — el contenedor mira tu carpeta a través de una ventana que abrimos a
propósito.

```bash
octave --version
python3 --version
gcc --version
```

Las tres herramientas del curso deben responder con su número de versión.

Debe responder algo así:

```
GNU Octave, version 7.3.0
Python 3.11.2
gcc (Debian 12.2.0-14+deb12u1) 12.2.0
```

**Si las tres responden con su versión, ya está. Terminaste.**

> **Si tu carpeta trae `extras/comprobar.sh`**, ejecútalo también. Hace el mismo cálculo
> en las tres herramientas y comprueba que dan el mismo resultado:
>
> ```bash
> bash extras/comprobar.sh
> ```
>
> Debe terminar con `Entorno listo. Ya se puede empezar la Práctica 1.`

---

## Paso 7 · Salir y apagar

Para salir del contenedor:

```bash
exit
```

Vuelves a tu terminal de Windows. **El contenedor sigue prendido**: puedes volver a
entrar con `docker compose exec metodos bash` las veces que quieras.

Para apagarlo del todo:

```bash
docker compose stop
```

---

## Y mañana, ¿qué?

Nada de lo anterior se repite. **Tu día a día son tres líneas:**

```bash
docker compose up -d                 # prender
docker compose exec metodos bash     # entrar
docker compose stop                  # apagar al terminar
```

Ya no hace falta `--build`: la imagen quedó construida y prender tarda dos segundos.

---

## 🧠 Lo que acabas de hacer, en tres frases

1. **Instalaste Docker**, que es el programa que sabe abrir «cajas» con software dentro.
2. **Construiste una imagen**: la caja del curso, con Octave, C y Python ya instalados.
   Eso es lo que tardó 15 minutos, y no se repite.
3. **Prendiste un contenedor**: una copia de esa caja, funcionando, con tu carpeta
   conectada por dentro.

La imagen es la **receta**; el contenedor es el **plato ya hecho**. De la misma receta
salen todos los platos que quieras.

---

## 😰 Si algo salió mal

| Salió esto | Es que… | Haz esto |
|---|---|---|
| `Cannot connect to the Docker daemon` | Docker Desktop está cerrado | Ábrelo y espera |
| `no configuration file provided` | La terminal está en otra carpeta | Repite el paso 3 |
| La terminal se queda en `Attaching to...` | Te faltó la `-d` | `Ctrl + C` y otra vez con `-d` |
| `service "metodos" is not running` | El contenedor está apagado | `docker compose up -d` |
| `bash: docker: command not found` | Estás **dentro** del contenedor | `exit` y escríbelo en Windows |
| `The container name ... is already in use` | Ya existe otro con ese nombre | `docker compose down` y vuelve a prender |

**Y si se enredó del todo**, esto lo deja como nuevo sin perder tus archivos:

```bash
docker compose down
docker compose up -d
```

---

## 📚 Qué leer después

| Documento | Para qué |
|---|---|
| **`COMANDOS.md`** | La hoja de comandos, para imprimir y tener al lado |
| **`README.md`** | Qué trae el entorno y cómo añadirle cosas |
| **`docker_tutorial.md`** | Docker explicado desde cero, si quieres entender **por qué** funciona |

No hace falta leerlos para trabajar. Con esta guía y `COMANDOS.md` tienes de sobra.
