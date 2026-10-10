#include <iostream>
#include <limits>
#include <iomanip>

using namespace std;

void limpiarBuffer() {
    cin.clear();
    cin.ignore(numeric_limits<streamsize>::max(), '\n');
}

int main() {
    int opcion;
    double a, b;

    cout << setprecision(17);

    do {
        cout << "\n--- CALCULADORA BÁSICA ---\n";
        cout << "1. Suma\n2. Resta\n3. Multiplicación\n4. División\n5. Salir\n";
        cout << "Seleccione una opción: ";

        if (!(cin >> opcion)) {
            cout << "Error: Entrada no válida. Ingrese un número del 1 al 5.\n";
            limpiarBuffer();
            continue;
        }

        if (opcion == 5) break;

        if (opcion >= 1 && opcion <= 4) {
            cout << "Ingrese el primer número: ";
            if (!(cin >> a)) {
                cout << "Error: Entrada no válida.\n";
                limpiarBuffer();
                continue;
            }

            cout << "Ingrese el segundo número: ";
            if (!(cin >> b)) {
                cout << "Error: Entrada no válida.\n";
                limpiarBuffer();
                continue;
            }

            switch (opcion) {
                case 1: 
                    cout << "Resultado: " << (a + b) << "\n"; 
                    break;
                case 2: 
                    cout << "Resultado: " << (a - b) << "\n"; 
                    break;
                case 3: 
                    cout << "Resultado: " << (a * b) << "\n"; 
                    break;
                case 4:
                    if (b == 0) {
                        cout << "Error: No se puede dividir entre cero.\n";
                    } else {
                        cout << "Resultado: " << (a / b) << "\n";
                    }
                    break;
            }
        } else {
            cout << "Opción inválida. Intente de nuevo.\n";
        }
    } while (opcion != 5);

    return 0;
}