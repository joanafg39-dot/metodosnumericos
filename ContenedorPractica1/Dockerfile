# Entorno del curso · Métodos Numéricos en Ingeniería (1151039) · 26-O
# UAM Azcapotzalco · CBI
#
# Construir y prender:  docker compose up -d --build
# Entrar a trabajar:    docker compose exec metodos bash
#
# Cada línea está explicada en docker_tutorial.md, partes 6 y 7.

FROM debian:bookworm-slim

# Octave, el compilador de C y el Python científico
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential gdb \
        octave gnuplot-nox \
        python3 python3-numpy python3-scipy python3-matplotlib python3-sympy \
        git nano \
    && rm -rf /var/lib/apt/lists/*

# Dos arreglos para que Octave se porte bien dentro de un contenedor:
#   1. No guardar el historial al salir: el intento falla y ensucia la salida
#      con un «error» que no lo es.
#   2. Que «octave» sea la versión de terminal. La otra busca una ventana que
#      aquí no existe y avisa de que no encuentra X11.
RUN mkdir -p /usr/share/octave/site/m/startup \
    && echo 'history_save(false);' > /usr/share/octave/site/m/startup/octaverc \
    && ln -sf /usr/bin/octave-cli /usr/local/bin/octave

# Acentos, hora de la Ciudad de México, y figuras a archivo en vez de a ventana
ENV LANG=C.UTF-8 \
    TZ=America/Mexico_City \
    MPLBACKEND=Agg

WORKDIR /trabajo
CMD ["bash"]
