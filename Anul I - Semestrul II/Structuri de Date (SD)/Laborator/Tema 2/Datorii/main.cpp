#include <fstream>

using namespace std;

ifstream citeste("datorii.in");
ofstream scrie("datorii.out");

int n, m, element, a, b, operatie, arbore[1000001];

void inserare(int nod, int st, int dr, int poz, int elem)
{
    if (st == dr)
    {
        arbore[nod] = elem;
        return;
    }

    if ((st+dr)/2 >= poz)
        inserare(nod*2, st, (st+dr)/2, poz, elem);
    else inserare(nod*2+1, (st+dr)/2+1, dr, poz, elem);

    arbore[nod] = arbore[nod*2] + arbore[nod*2+1];
}

void modificare(int nod, int st, int dr, int poz, int elem)
{
    if (st == dr)
    {
        arbore[nod] -= elem;
        return;
    }

    if ((st+dr)/2 >= poz)
        modificare(nod*2, st, (st+dr)/2, poz, elem);
    else modificare(nod*2+1, (st+dr)/2+1, dr, poz, elem);

    arbore[nod] = arbore[nod*2] + arbore[nod*2+1];
}

int suma(int nod, int st, int dr, int lims, int limd)
{
    if (lims > dr || limd < st)
        return 0;

    if (lims <= st && dr <= limd)
        return arbore[nod];

    return suma(nod*2, st, (st+dr)/2, lims, limd) + suma(nod*2+1, (st+dr)/2+1, dr, lims, limd);
}

void citire()
{
    citeste >> n >> m;
    for (int i = 1; i<=n; i++)
    {
        citeste >> element;
        inserare(1, 1, n, i, element);
    }
    for (int i=1; i<=m; i++)
    {
        citeste >> operatie >> a >> b;
        if (operatie == 1)
            scrie << suma(1, 1, n, a, b) << '\n';
        else if (operatie == 0)
            modificare(1, 1, n, a, b);
    }
}

int main()
{
    ios::sync_with_stdio(false);
    citire();
    return 0;
}
