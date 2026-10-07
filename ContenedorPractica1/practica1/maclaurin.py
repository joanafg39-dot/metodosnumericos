#!/usr/bin/env python3
"""maclaurin.py — Práctica 1: la serie de Maclaurin de e^x y el criterio de paro, en Python.

Suma términos de e^x = 1 + x + x^2/2! + x^3/3! + ... hasta que el error relativo
aproximado llega a la tolerancia del criterio de Scarborough. Es el ciclo de la
lámina 24 de la unidad I, e imprime la misma tabla que maclaurin.m, maclaurin.c y
la lámina 25.

UEA 1151039 · Métodos Numéricos en Ingeniería · UAM Azcapotzalco · 26-O

Dentro del contenedor, en la carpeta practica1:
    python3 maclaurin.py

Este programa está completo.
"""
import math

# ============================= DATOS =============================
X = 0.5         # el punto donde se evalúa e^x
CIFRAS = 3      # cifras significativas que se piden
NMAX = 30       # máximo de términos
# =================================================================

ENCABEZADO = "términos         aproximación        et (%)        ea (%)"


def main():
    es = 0.5 * 10.0 ** (2 - CIFRAS)          # criterio de Scarborough, en %
    verdadero = math.exp(X)
    aprox, termino, n = 0.0, 1.0, 0

    print("Práctica 1 · Serie de Maclaurin de e^x · Python")
    print(f"x = {X:g}, {CIFRAS:d} cifras significativas: es = {es:g} % (criterio de Scarborough)")
    print(f"Valor verdadero: exp({X:g}) = {verdadero:.15f}")
    print()
    print(ENCABEZADO)

    while True:
        anterior = aprox
        aprox = aprox + termino
        n = n + 1
        termino = termino * X / n                         # el término siguiente, x^n / n!
        ea = abs((aprox - anterior) / aprox) * 100.0      # error relativo aproximado, en %
        et = abs((verdadero - aprox) / verdadero) * 100.0
        if n == 1:
            print(f"{n:8d} {aprox:20.15f} {et:13.6g} {'-':>13}")
        else:
            print(f"{n:8d} {aprox:20.15f} {et:13.6g} {ea:13.6g}")
        if ea <= es or n >= NMAX:                         # «hasta que»
            break

    print()
    if ea <= es:
        print(f"Se alcanzó ea <= es con {n} términos.")
    else:
        print(f"No se alcanzó la tolerancia en {NMAX} términos.")
    print(f"Aproximación: {aprox:.15f}   error verdadero: {et:g} %")


if __name__ == "__main__":
    main()
