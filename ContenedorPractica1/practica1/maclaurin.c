/* maclaurin.c — Práctica 1: la serie de Maclaurin de e^x y el criterio de paro, en C.
 *
 * Suma términos de e^x = 1 + x + x^2/2! + x^3/3! + ... hasta que el error relativo
 * aproximado llega a la tolerancia del criterio de Scarborough. Es el ciclo de la
 * lámina 24 de la unidad I, e imprime la misma tabla que maclaurin.m, maclaurin.py y
 * la lámina 25.
 *
 * UEA 1151039 · Métodos Numéricos en Ingeniería · UAM Azcapotzalco · 26-O
 *
 * Dentro del contenedor, en la carpeta practica1:
 *     gcc -O2 -std=c17 -Wall -o maclaurin maclaurin.c -lm
 *     ./maclaurin
 *
 * Faltan dos líneas, marcadas COMPLETAR 1 y COMPLETAR 2.
 */
#include <math.h>
#include <stdio.h>

/* ============================= DATOS ============================= */
static const double X = 0.5;   /* el punto donde se evalúa e^x          */
static const int CIFRAS = 3;   /* cifras significativas que se piden    */
#define NMAX 30                /* máximo de términos                    */
/* ================================================================= */

#define ENCABEZADO "términos         aproximación        et (%)        ea (%)"

int main(void)
{
    double es = 0.5 * pow(10.0, 2 - CIFRAS);    /* criterio de Scarborough, en % */
    double verdadero = exp(X);
    double aprox = 0.0, anterior, termino = 1.0, ea, et;
    int n = 0;

    printf("Práctica 1 · Serie de Maclaurin de e^x · C\n");
    printf("x = %g, %d cifras significativas: es = %g %% (criterio de Scarborough)\n",
           X, CIFRAS, es);
    printf("Valor verdadero: exp(%g) = %.15f\n\n", X, verdadero);
    printf("%s\n", ENCABEZADO);

    do {
        anterior = aprox;
        aprox = aprox + termino;
        n = n + 1;
        /* COMPLETAR 1: el término siguiente, x^n / n!, a partir del anterior. */
        termino = 0.0;   /* <- sustituya 0.0 por la expresión correcta */
        /* COMPLETAR 2: el error relativo aproximado, en %. Ojo: fabs, no abs. */
        ea = 0.0;   /* <- sustituya 0.0 por la expresión correcta */
        et = fabs((verdadero - aprox) / verdadero) * 100.0;
        if (n == 1)
            printf("%8d %20.15f %13.6g %13s\n", n, aprox, et, "-");
        else
            printf("%8d %20.15f %13.6g %13.6g\n", n, aprox, et, ea);
    } while (!(ea <= es || n >= NMAX));    /* «hasta que»: en C se niega la condición */

    printf("\n");
    if (ea <= es)
        printf("Se alcanzó ea <= es con %d términos.\n", n);
    else
        printf("No se alcanzó la tolerancia en %d términos.\n", NMAX);
    printf("Aproximación: %.15f   error verdadero: %g %%\n", aprox, et);
    return 0;
}
