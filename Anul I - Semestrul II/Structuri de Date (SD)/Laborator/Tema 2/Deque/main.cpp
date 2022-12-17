#include <iostream>
#include <fstream>

using namespace std;

ifstream citeste("deque.in");
ofstream scrie("deque.out");

int n, k, a;
int v[5000010], dequee[5000010];
long long suma;


void citire ()
{
    citeste >> n >> k;
    for (int i=1; i<=n; i++)
        citeste >> v[i];
}

void parcurgere ()
{
    int inceput = 1, sfarsit = 0;
    for (int indice_valoare=1; indice_valoare<=n; indice_valoare++)
    {
        while (inceput <= sfarsit && v[indice_valoare] <= v[dequee[sfarsit]])
            sfarsit --;
        sfarsit ++;
        dequee[sfarsit] = indice_valoare;
        if (k  <= indice_valoare)
        {
            suma = suma + v[dequee[inceput]];
            if (dequee[inceput] == indice_valoare - k + 1)
                inceput ++;
        }
    }
}

int main()
{
    citire();
    parcurgere();
    scrie << suma;
    return 0;
}
