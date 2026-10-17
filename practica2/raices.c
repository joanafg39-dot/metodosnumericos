#include <stdio.h>
#include <math.h>

#define DESCRIPCION "f(t4) = d/a cos(t4) - d/c cos(t2) + (a^2 - b^2 + c^2 + d^2)/(2 a c) - cos(t2 - t4), a = 40, b = 120, c = 80, d = 100, t2 = 60 grados"
#define DESCR_G     "g(t4) = t4 + f(t4) / 2"

static const double LA = 40.0;    /* manivela, mm */
static const double LB = 120.0;   /* acoplador, mm */
static const double LC = 80.0;    /* balancín, mm */
static const double LD = 100.0;   /* bancada, mm */
static const double TH2 = 1.0471975511965976;  /* ángulo de la manivela, rad (60 grados) */

static const double A = 0.5, B = 1.5;   /* intervalo de los métodos cerrados */
static const double X0       = 1.0;     /* inicio de los métodos abiertos */
static const double DELTA    = 0.01;    /* incremento de la secante modificada */
static const double TOL      = 0.5;     /* tolerancia: ea en % */
#define NMAX 50                         /* máximo de iteraciones */

static double f(double x)
{
    return LD/LA*cos(x) - LD/LC*cos(TH2) + (LA*LA - LB*LB + LC*LC + LD*LD)/(2*LA*LC) - cos(TH2 - x);
}

int main(void)
{
    printf("=========================================================================\n");
    printf("      Mecanismo de cuatro barras - Metodo de Biseccion (C)\n");
    printf("=========================================================================\n");
    printf("Ecuacion: %s\n\n", DESCRIPCION);

    double a = A;
    double b = B;
    double xr = 0.0;
    double xr_prev = 0.0;
    double ea = 100.0;

    if (f(a) * f(b) >= 0) {
        printf("Error: f(a) y f(b) deben tener signos opuestos.\n");
        return 1;
    }

    printf("%-5s %-12s %-12s %-12s %-12s %-12s\n", "i", "a", "b", "xr", "f(xr)", "ea (%)");
    printf("-------------------------------------------------------------------------\n");

    for (int i = 1; i <= NMAX; i++) {
        xr_prev = xr;
        xr = (a + b) / 2.0;

        if (i > 1) {
            ea = fabs((xr - xr_prev) / xr) * 100.0;
        }

        printf("%-5d %-12.6f %-12.6f %-12.6f %-12.6f ", i, a, b, xr, f(xr));
        if (i == 1) {
            printf("%-12s\n", "---");
        } else {
            printf("%-12.4f\n", ea);
        }

        if (f(a) * f(xr) < 0) {
            b = xr;
        } else if (f(a) * f(xr) > 0) {
            a = xr;
        } else {
            ea = 0.0;
            break;
        }

        if (i > 1 && ea < TOL) {
            printf("-------------------------------------------------------------------------\n");
            printf("Convergencia alcanzada en la iteracion %d con ea = %.4f%%\n", i, ea);
            printf("Raiz aproximada t4 = %.6f rad (%.4f grados)\n", xr, xr * 180.0 / M_PI);
            break;
        }
    }

    return 0;
}