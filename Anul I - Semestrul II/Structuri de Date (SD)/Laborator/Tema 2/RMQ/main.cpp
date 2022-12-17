#include <iostream>
#include <fstream>
#include <math.h>

using namespace std;

ifstream citeste("rmq.in");
ofstream scrie("rmq.out");

int n, m, x, y;
int v[100001];
int mat[100001][17];
int logaritm[100001];

void initializare_logaritm ()
{
    logaritm[1] = 0;
    for (int i=2; i<=n; i++)
        logaritm[i] = logaritm[i/2] + 1;
}

void gaseste_minim (int x, int y)
{
    int lungime = y - x + 1;
    int k = logaritm[lungime];

    if (mat[x][k] <= mat[y-(1<<k)+1][k])
        scrie << mat[x][k] << '\n';
    else scrie << mat[y-(1<<k)+1][k] << '\n';
}

void initializare_matrice ()
{
    // Cautam minimul prin impartirea intervalelor in puteri ale lui 2.
    // Daca avem interval de 1 (cazul citirii), automat cel mai mic element e chiar el.
    // Minimul din secventa [3 4 6 5 7 9 8 3] se calculeaza: minim(minim [3 4 6 5], minim [7 9 8 3]).

    // Daca intervalul nu se imparte la fix suprapunem intervalele.
    // Minimul din secventa [3 4 6 5 7 9 3] se calculeaza: minim(minim [3 4 6 5], minim [5 7 9 3]).

    for(int i=1; i<=n; i++)
    {
        citeste >> v[i];
        mat[i][0] = v[i];
    }

    // 1 << (i-1) --------> 2 ^ (i-1) [impartim pe biti]
    // j+(1<<i)-1 <= n ---> conditie sa nu iesim din interval

    for (int i=1; i<=17; i++)
        for(int j=1; j+(1<<i)-1 <= n; j++)
            if (mat[j][i-1] <= mat[j+(1<<(i-1))][i-1])
                mat[j][i] = mat[j][i-1];
            else
                mat[j][i] = mat[j+(1<<(i-1))][i-1];
}

void parcurgere_intervale ()
{
    for(int i=1; i<=m; i++)
    {
        citeste >> x >> y;
        gaseste_minim(x, y);
    }
}

int main()
{
    citeste >> n >> m;

    initializare_logaritm();

    initializare_matrice();

    parcurgere_intervale();

    return 0;
}
