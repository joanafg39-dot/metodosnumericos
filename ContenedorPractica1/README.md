# Práctica 1 · Cómo empezar

**UEA 1151039 · Métodos Numéricos en Ingeniería · 26-O · UAM Azcapotzalco**

La Práctica 1 es la continuación de la Tarea 1 y **se hace en equipo, en el repositorio
de la Tarea 1 de uno de ustedes**. Desde hoy ése es el repositorio del equipo: ahí van
también las prácticas siguientes, cada una en su carpeta.

## 0 · Elijan el repositorio

Escojan el repositorio de la Tarea 1 de un integrante. Su dueño invita a los demás y al
profesor como colaboradores: en GitHub, **Settings → Collaborators → Add people**. Cada
quien acepta la invitación que le llega por correo y lo clona en su computadora.

## 1 · Copien esta carpeta al repositorio

A la **raíz** del repositorio (donde está la carpeta `tarea1/`) copien:

- la carpeta `practica1/`
- `compose.yaml`, `Dockerfile` y `.dockerignore`

Si ya había un `compose.yaml` y un `Dockerfile` en la raíz, reemplácenlos por éstos: son el
mismo entorno, pero éste ve todo el repositorio.

El repositorio debe quedar así:

```
repositorio-del-equipo/
├── LICENSE
├── .gitignore
├── compose.yaml
├── Dockerfile
├── .dockerignore
├── tarea1/          ← la del dueño del repositorio; se queda como está
└── practica1/
    ├── COMO_CORRER.md
    ├── README.md        ← aquí escriben el reporte
    ├── maclaurin.c
    ├── maclaurin.m
    └── maclaurin.py
```

## 2 · Agreguen una línea al `.gitignore`

```
practica1/maclaurin
```

Es el ejecutable que crea `gcc`; no se sube al repositorio.

## 3 · Prendan el contenedor desde la raíz del repositorio

Cada integrante, en su computadora:

```bash
docker compose up -d
docker compose exec metodos bash
cd practica1
```

La imagen ya la construyeron en la Tarea 1, así que tarda dos segundos.

> **¿Sale `The container name "/metodos_equipo" is already in use`?** Ya hay otro
> contenedor con ese nombre. Bórrenlo con `docker rm -f metodos_equipo` y vuelvan a
> prender. Los archivos no se pierden.

Antes de empezar a trabajar, `git pull`; al terminar, `git add`, `git commit` y `git push`.
Cada integrante hace al menos una confirmación.

## 4 · Sigue `practica1/COMO_CORRER.md`

Ahí están los comandos de cada programa y la tabla que debe salir.
