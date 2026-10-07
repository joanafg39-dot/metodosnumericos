/* raiz.c — √2 por el método babilónico, en C.
 * El mismo cálculo que raiz.m y raiz.py: si los tres coinciden hasta la última
 * cifra, el entorno está bien construido.
 * UEA 1151039 · Métodos Numéricos en Ingeniería · UAM Azcapotzalco
 *
 *   gcc -O2 -std=c17 -o raiz raiz.c -lm
 */
#include <stdio.h>

int main(void)
{
    double x = 1.0;                  /* conjetura inicial */
    for (int k = 0; k < 4; ++k)
        x = 0.5 * (x + 2.0 / x);     /* la misma regla, repetida */
    printf("%.12f\n", x);
    return 0;
}
