#include <iostream>
#include <bitset>
#include <cmath>
#include <cstdint>

using namespace std;

// Para convertir entre float y sus bits
union FloatBits {
    float valor;
    uint32_t bits;
};

// Obtener partes del número
uint32_t obtenerSigno(uint32_t bits) {
    return (bits >> 31) & 1;
}

uint32_t obtenerExponente(uint32_t bits) {
    return (bits >> 23) & 0xFF;
}

uint32_t obtenerMantisa(uint32_t bits) {
    return bits & 0x7FFFFF;
}

uint32_t formarResultado(uint32_t signo, uint32_t exponente, uint32_t mantisa) {
    return (signo << 31) | (exponente << 23) | (mantisa & 0x7FFFFF);
}

// Mostrar los bits del número
void mostrarBits(float num) {
    FloatBits fb;
    fb.valor = num;
    cout << num << " -> " << bitset<32>(fb.bits) << endl;
}

// DIVIDIR en punto flotante
float dividirFlotantes(float x, float y) {
    const int sesgo = 127;

    FloatBits A, B;
    A.valor = x;
    B.valor = y;

    // Casos especiales
    if (x == 0) return 0.0f;
    if (y == 0) return INFINITY;

    // Separar partes
    uint32_t signoA = obtenerSigno(A.bits);
    uint32_t expA   = obtenerExponente(A.bits);
    uint32_t mantA  = obtenerMantisa(A.bits);

    uint32_t signoB = obtenerSigno(B.bits);
    uint32_t expB   = obtenerExponente(B.bits);
    uint32_t mantB  = obtenerMantisa(B.bits);

    // Agregar el 1 oculto para la mantisa
    mantA |= 1 << 23;
    mantB |= 1 << 23;

    // Dividir mantisas con precisión cddsdddddd
    uint64_t mantResultado = ((uint64_t)mantA << 23) / mantB;

    // Restar exponentes y agregar sesgo
    int expResultado = (int)expA - (int)expB + sesgo;

    // Normalizar (que empiece en 1)
    while ((mantResultado & (1 << 23)) == 0 && expResultado > 0) {
        mantResultado <<= 1;
        expResultado--;
    }

    // Redondear (truncar un poquiito)
    mantResultado &= 0x7FFFFF;

    // Ante posibles ERRORES
    if (expResultado >= 255) {
        cout << "Overflow: exponente muy grande.\n";
        return INFINITY;
    }
    if (expResultado <= 0) {
        cout << "Underflow: exponente muy pequeño.\n";
        return 0.0f;
    }

    // ARMAR EL NUMERO FINAL
    uint32_t signoFinal = signoA ^ signoB;
    uint32_t resultadoBits = formarResultado(signoFinal, expResultado, mantResultado);

    FloatBits resultado;
    resultado.bits = resultadoBits;
    return resultado.valor;
}

int main() {
    float num1, num2;

    cout << "Ingresa (1er)X: ";
    cin >> num1;
    cout << "Ingresa (2do)Y: ";
    cin >> num2;

    float resultadoEmulado = dividirFlotantes(num1, num2);
    float resultadoNormal = num1 / num2;

    cout << "\nAlgoritmo(emulado): ";
    mostrarBits(resultadoEmulado);
    cout << "En C++ (directo): ";
    mostrarBits(resultadoNormal);

    return 0;
}
