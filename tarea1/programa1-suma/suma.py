import sys

a = float(sys.argv[1]) if len(sys.argv) > 1 else 0.1
b = float(sys.argv[2]) if len(sys.argv) > 2 else 0.2

print(f"{a + b:.17g}")