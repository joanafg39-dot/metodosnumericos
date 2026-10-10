#!/usr/bin/env python3
"""raiz.py — √2 por el método babilónico, en Python.

El mismo cálculo que raiz.m y raiz.c. Python es la herramienta de verificación
del curso: aquí abajo se compara además contra math.sqrt.

UEA 1151039 · Métodos Numéricos en Ingeniería · UAM Azcapotzalco
"""
import math

x = 1.0                          # conjetura inicial
for _ in range(4):
    x = 0.5 * (x + 2.0 / x)      # la misma regla, repetida

print(f"{x:.12f}")

if __name__ == "__main__" and False:   # comprobación, desactivada por defecto
    print("referencia:", f"{math.sqrt(2.0):.12f}")
    print("error relativo:", abs(x - math.sqrt(2.0)) / math.sqrt(2.0))
