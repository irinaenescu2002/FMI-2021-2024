#include <fstream>
using namespace std;
ifstream citeste("kami.in");
ofstream scrie("kami.out");
long maxim, zapada[999999], n, operatie, nivel, zapada_noua, zapada_totala;
inline long max(long x, long y) {return x>y ? x:y;}
inline long avalansa (long nivel)
{
    zapada_totala = zapada[nivel];
    for(long i=nivel-1; i>=1; i--)
    {
        if(zapada_totala <= zapada[i]) return i;
        if(zapada_totala > maxim) return 0;
        zapada_totala += zapada[i];
    }
    return 0;
}
int main()
{
    citeste >> n;
    for(long i=1; i<=n; i++)
    {
        citeste >> zapada[i];
        maxim = max(maxim,zapada[i]);
    }
    citeste >> n;
    while(n)
    {
        citeste >> operatie;
        if(!operatie)
        {
            citeste >> nivel >> zapada_noua;
            zapada[nivel] = zapada_noua;
            maxim = max(maxim, zapada_noua);
        }
        else
        {
            citeste >> nivel;
            scrie << avalansa(nivel) << '\n';
        }
        n--;
    }
}
