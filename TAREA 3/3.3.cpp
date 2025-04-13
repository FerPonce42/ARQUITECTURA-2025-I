#include <iostream>
#include <vector>
#include <bitset>
#include <cmath>
using namespace std;

// Convierte un entero a binario en complemento a 2 con n bits
vector<int> decimalToBinary(int num, int n) {
    vector<int> bin(n);
    if (num < 0) num = pow(2, n) + num; // complemento a 2 implícito
    for (int i = n - 1; i >= 0; --i) {
        bin[i] = num % 2;
        num /= 2;
    }
    return bin;
}

// Convierte un binario a decimal (con signo)
int binaryToDecimal(const vector<int>& bin) {
    int n = bin.size();
    int result = 0;
    bool negative = bin[0] == 1;
    for (int i = 0; i < n; ++i)
        result += bin[i] * pow(2, n - i - 1);
    if (negative) result -= pow(2, n);
    return result;
}

// Suma binaria de dos vectores (n bits)
vector<int> addBinary(const vector<int>& a, const vector<int>& b) {
    int n = a.size();
    vector<int> result(n);
    int carry = 0;
    for (int i = n - 1; i >= 0; --i) {
        int sum = a[i] + b[i] + carry;
        result[i] = sum % 2;
        carry = sum / 2;
    }
    return result;
}

// Complemento a 2
vector<int> twoComplement(const vector<int>& bin) {
    int n = bin.size();
    vector<int> one(n, 0);
    one[n - 1] = 1;
    vector<int> inv(n);
    for (int i = 0; i < n; ++i) inv[i] = bin[i] == 0 ? 1 : 0;
    return addBinary(inv, one);
}

// Corrimiento aritmético a la derecha sobre A, Q y Q-1
void arithmeticRightShift(vector<int>& A, vector<int>& Q, int& Q_1) {
    int msb_A = A[0];
    Q_1 = Q.back();
    for (int i = Q.size() - 1; i > 0; --i) Q[i] = Q[i - 1];
    Q[0] = A.back();
    for (int i = A.size() - 1; i > 0; --i) A[i] = A[i - 1];
    A[0] = msb_A;
}

// Imprime binario
void printBin(const vector<int>& bin) {
    for (int bit : bin) cout << bit;
}

// Algoritmo de Booth
void boothMultiplication(int M_dec, int Q_dec, int n) {
    vector<int> M = decimalToBinary(M_dec, n);
    vector<int> Q = decimalToBinary(Q_dec, n);
    vector<int> A(n, 0);
    int Q_1 = 0;

    cout << "Paso Inicial: A = "; printBin(A);
    cout << ", Q = "; printBin(Q);
    cout << ", Q-1 = " << Q_1 << endl;

    for (int count = n; count > 0; --count) {
        int Q0 = Q.back();

        if (Q0 == 1 && Q_1 == 0) {
            A = addBinary(A, twoComplement(M));
            cout << "A = A - M  -> A = "; printBin(A); cout << endl;
        }
        else if (Q0 == 0 && Q_1 == 1) {
            A = addBinary(A, M);
            cout << "A = A + M  -> A = "; printBin(A); cout << endl;
        }

        arithmeticRightShift(A, Q, Q_1);
        cout << "Shift der -> A = "; printBin(A);
        cout << ", Q = "; printBin(Q);
        cout << ", Q-1 = " << Q_1 << endl;
    }

    vector<int> result;
    result.insert(result.end(), A.begin(), A.end());
    result.insert(result.end(), Q.begin(), Q.end());

    cout << "\nResultado binario: "; printBin(result);
    cout << "\nResultado decimal: " << binaryToDecimal(result) << endl;
}

int main() {
    int M, Q, n;
    cout << "Ingrese el multiplicando (M): "; cin >> M;
    cout << "Ingrese el multiplicador (Q): "; cin >> Q;
    cout << "Ingrese el numero de bits (n): "; cin >> n;

    boothMultiplication(M, Q, n);
    return 0;
}   

