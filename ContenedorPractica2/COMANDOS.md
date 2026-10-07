# 🐳 Hoja de comandos · Docker

**UEA 1151039 · Métodos Numéricos en Ingeniería · 26-O · UAM Azcapotzalco**

Para imprimir y tener al lado. Todo lo que hace falta durante el trimestre cabe aquí.

---

## ⚠️ Antes de nada

1. **Docker Desktop tiene que estar abierto.** Si no, ningún comando responde.
2. La terminal tiene que estar **en la carpeta donde está `compose.yaml`**.
3. Los comandos de Docker se escriben **en Windows**, no dentro del contenedor.

---

## 🔑 Los tres de todos los días

| Escribes | Qué hace |
|---|---|
| `docker compose up -d` | **PRENDE** el contenedor |
| `docker compose exec metodos bash` | **ENTRA** a trabajar |
| `docker compose stop` | **APAGA** el contenedor |

Con esos tres se trabaja el trimestre entero. Y se usan en ese orden.

```
  Windows                          Dentro del contenedor
  ───────                          ─────────────────────
  docker compose up -d       →     (se prende)
  docker compose exec metodos bash →  root@a8eacd:/trabajo#
                                       octave  gcc  python3
  exit                       ←     (sales, pero sigue prendido)
  docker compose stop        →     (se apaga)
```

---

## 💻 Dentro del contenedor

Una vez que ves el prompt `root@a8eacd:/trabajo#`, estás en Linux:

| Escribes | Qué hace |
|---|---|
| `octave programa.m` | Ejecuta un guion de Octave |
| `gcc -O2 -std=c17 -o programa programa.c -lm` | **Compila** un programa de C |
| `./programa` | Lo ejecuta (los dos pasos de C) |
| `python3 programa.py` | Ejecuta un guion de Python |
| `ls` | Lista los archivos. Son **los mismos** que ves en Windows |
| `exit` | Sales del contenedor. **No lo apaga** |

> Si escribes `docker` estando dentro sale `bash: docker: command not found`.
> **Está bien que así sea**: dentro del contenedor no hay Docker. Sal con `exit` primero.

---

## 🔍 Cuando algo no funciona

**Antes de borrar nada, mira qué pasa. En este orden:**

| Escribes | Qué te dice |
|---|---|
| `docker compose ps` | ¿Está encendido? |
| `docker compose ps -a` | ¿Existe, aunque esté apagado? |
| `docker compose logs` | ¿Qué dijo antes de fallar? |

Y si quieres empezar de cero, sin miedo:

```bash
docker compose down        # borra el contenedor
docker compose up -d       # lo crea otra vez, limpio
```

**No pierdes nada**: tus archivos están en tu carpeta de Windows, no dentro del
contenedor.

---

## 🔨 Una sola vez (o si cambia el `Dockerfile`)

```bash
docker compose up -d --build
```

La primera vez tarda entre 5 y 15 minutos porque descarga e instala todo. Después,
`docker compose up -d` a secas tarda dos segundos.

---

## 🛑 Apagar y borrar no es lo mismo

| Escribes | El contenedor | ¿Sigue en Docker Desktop? | ¿Mis archivos? |
|---|---|---|---|
| `docker compose stop` | Se **apaga** | Sí, apagado | Intactos |
| `docker compose start` | Se vuelve a prender | Sí, encendido | Intactos |
| `docker compose down` | Se apaga **y se borra** | **No, desaparece** | Intactos |

Si le diste `down` y desapareció de Docker Desktop, **no hiciste nada malo**. Eso es lo
que hace. `docker compose up -d` lo vuelve a crear en dos segundos.

**Para el día a día usa `stop`.**

---

## 🆘 Los seis errores que más salen

| Sale esto | Es que… | Haz esto |
|---|---|---|
| `Cannot connect to the Docker daemon` | Docker Desktop está cerrado | Ábrelo y espera a que el icono deje de moverse |
| `bash: docker: command not found` | Escribiste un comando de Docker **dentro** del contenedor | `exit` y escríbelo en Windows |
| La terminal se queda colgada en `Attaching to...` | Pusiste `up` sin la `-d` | `Ctrl + C`, y después `docker compose up -d` |
| `service "metodos" is not running` | El contenedor está apagado | `docker compose up -d` primero |
| `no configuration file provided` | La terminal está en otra carpeta | `cd` a la carpeta del `compose.yaml` |
| `The container name ... is already in use` | Ya existe otro con ese nombre | `docker compose down` y vuelve a prender |

---

## 📖 Qué significa cada palabra

```
docker compose exec metodos bash
   │       │      │      │     └── el programa que quiero abrir dentro
   │       │      │      └──────── el nombre del servicio, el del compose.yaml
   │       │      └─────────────── "ejecuta esto en el contenedor que ya está prendido"
   │       └────────────────────── lee el archivo compose.yaml
   └────────────────────────────── el programa Docker
```

```
gcc -O2 -std=c17 -o programa programa.c -lm
 │   │      │      │     │        │       └── enlaza la biblioteca matemática
 │   │      │      │     │        └────────── el archivo que escribiste
 │   │      │      │     └─────────────────── cómo se llamará el ejecutable
 │   │      │      └───────────────────────── "el de salida se va a llamar..."
 │   │      └──────────────────────────────── qué versión del lenguaje C
 │   └─────────────────────────────────────── optimiza el resultado
 └─────────────────────────────────────────── el compilador de C
```

---

## ✅ Cómo sé que todo está bien

```bash
docker compose up -d
docker compose exec metodos bash -c "octave --version | head -1; python3 --version; gcc --version | head -1"
```

Las tres herramientas deben responder con su número de versión.

Y si tu carpeta trae `extras/comprobar.sh`:

```bash
docker compose exec metodos bash extras/comprobar.sh
```

Debe terminar con `Entorno listo. Ya se puede empezar la Práctica 1.`

---

*¿No entiendes qué es un contenedor, una imagen o un volumen? Está explicado desde cero
en `docker_tutorial.md`. Esta hoja es sólo para tenerla a mano.*
