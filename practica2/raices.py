import numpy as np

# Constantes físicas del mecanismo de cuatro barras
LA = 40.0  # manivela, mm
LB = 120.0  # acoplador, mm
LC = 80.0  # balancín, mm
LD = 100.0  # bancada, mm
TH2 = 1.0471975511965976  # ángulo de la manivela, rad (60 grados)

# Parámetros de los métodos
X0 = 1.0  # valor inicial


def f(x):
  return (
      (LD / LA) * np.cos(x)
      - (LD / LC) * np.cos(TH2)
      + (LA**2 - LB**2 + LC**2 + LD**2) / (2 * LA * LC)
      - np.cos(TH2 - x)
  )


if __name__ == "__main__":
  print("Mecanismo de cuatro barras - Métodos Numéricos (Python)")
  print(f"Ángulo de la manivela TH2 = {TH2:.4f} rad")
  print(f"f(X0) = {f(X0):.6f}")