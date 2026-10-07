#!/usr/bin/env bash
# =============================================================================
#  Comprobación del entorno · Métodos Numéricos en Ingeniería (1151039) · 26-O
#
#  Ejecuta el mismo cálculo —√2 por el método babilónico, el de la lámina de
#  apertura del curso— en las tres herramientas, y comprueba que las tres dan
#  el mismo resultado.
#
#  Se ejecuta desde dentro del contenedor:
#      docker compose up -d
#      docker compose exec metodos bash extras/comprobar.sh
# =============================================================================
set -euo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EJ="$AQUI/ejemplos"
ROJO=$'\033[0;31m'; VERDE=$'\033[0;32m'; NEGRITA=$'\033[1m'; FIN=$'\033[0m'

fallos=0

titulo() { printf '\n%s%s%s\n' "$NEGRITA" "$1" "$FIN"; }
ok()     { printf '  %s✓%s %s\n' "$VERDE" "$FIN" "$1"; }
mal()    { printf '  %s✗%s %s\n' "$ROJO" "$FIN" "$1"; fallos=$((fallos + 1)); }

titulo "1 · Versiones instaladas"
printf '  %-14s %s\n' "Octave"  "$(octave-cli --version | head -1)"
printf '  %-14s %s\n' "gcc"     "$(gcc --version | head -1)"
printf '  %-14s %s\n' "Python"  "$(python3 --version)"
printf '  %-14s %s\n' "NumPy"   "$(python3 -c 'import numpy; print(numpy.__version__)')"
printf '  %-14s %s\n' "SciPy"   "$(python3 -c 'import scipy; print(scipy.__version__)')"
printf '  %-14s %s\n' "Matplotlib" "$(python3 -c 'import matplotlib; print(matplotlib.__version__)')"

titulo "2 · El mismo cálculo en las tres herramientas"
echo "  √2 por el método babilónico, cuatro iteraciones, doble precisión."
echo

oct=$(octave-cli --quiet "$EJ/raiz.m")
printf '  %-14s %s\n' "Octave" "$oct"

gcc -O2 -std=c17 -o /tmp/raiz "$EJ/raiz.c" -lm
c=$(/tmp/raiz)
printf '  %-14s %s\n' "C" "$c"

py=$(python3 "$EJ/raiz.py")
printf '  %-14s %s\n' "Python" "$py"

titulo "3 · ¿Coinciden?"
if [ "$oct" = "$c" ] && [ "$c" = "$py" ]; then
    ok "Las tres dan $oct — el entorno es coherente."
else
    mal "Las tres NO coinciden. Revise las versiones de arriba."
fi

titulo "4 · Escritura en el volumen"
salida="$AQUI/.comprobacion_entorno.txt"
if printf 'Entorno comprobado: %s\n' "$(date -Iseconds)" > "$salida" 2>/dev/null; then
    ok "Se puede escribir en la carpeta montada (salió .comprobacion_entorno.txt)."
    rm -f "$salida"
else
    mal "No se puede escribir en /trabajo: revise el montaje del volumen."
fi

titulo "5 · Figuras sin ventana"
if python3 -c "
import matplotlib; matplotlib.use('Agg')
import matplotlib.pyplot as plt
plt.plot([0,1],[0,1]); plt.savefig('/tmp/prueba.png'); print('ok')
" > /dev/null 2>&1; then
    ok "matplotlib guarda figuras en archivo."
else
    mal "matplotlib no pudo guardar una figura."
fi

echo
if [ "$fallos" -eq 0 ]; then
    printf '%s%s  Entorno listo. Ya se puede empezar la Práctica 1.%s\n\n' "$NEGRITA" "$VERDE" "$FIN"
else
    printf '%s%s  %d comprobación(es) fallaron.%s\n\n' "$NEGRITA" "$ROJO" "$fallos" "$FIN"
    exit 1
fi
