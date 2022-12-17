#include <iostream>
#include <fstream>

using namespace std;

ifstream citeste("arbint.in");
ofstream scrie("arbint.out");

int n, m, element, a, b, operatie;
int arbore[1000001];

void modificare(int nod, int st, int dr, int poz, int elem)
{
    if (poz < st || poz > dr)
        return;

    if (st == dr)
    {
        arbore[nod] = elem;
        return;
    }

    if ((st+dr)/2 >= poz)
        modificare(nod*2, st, (st+dr)/2, poz, elem);
    else modificare(nod*2+1, (st+dr)/2+1, dr, poz, elem);

    if (arbore[nod*2] > arbore[nod*2+1])
        arbore[nod] = arbore[nod*2];
    else arbore[nod] = arbore[nod*2+1];
}

int maxim(int nod, int st, int dr, int lims, int limd)
{
    if (lims > dr || limd < st)
        return 0;

    if (lims <= st && dr <= limd)
        return arbore[nod];

    int x = maxim(nod*2, st, (st+dr)/2, lims, limd);
    int y = maxim(nod*2+1, (st+dr)/2+1, dr, lims, limd);
    if (x > y)
        return x;
    else return y;
}

void citire()
{
    citeste >> n >> m;
    for (int i = 1; i<=n; i++)
    {
        citeste >> element;
        modificare(1, 1, n, i, element);
    }
    for (int i=1; i<=m; i++)
    {
        citeste >> operatie >> a >> b;
        if (operatie == 0)
            scrie << maxim(1, 1, n, a, b) << '\n';
        else if (operatie == 1)
            modificare(1, 1, n, a, b);
    }
}

int main()
{
    citire();
    return 0;
}
