#include <iostream>
#include <fstream>

using namespace std;

ifstream citeste("mit.in");
ofstream scrie("mit.out");

int n, m, element, a, b, operatie, bns;
int arbore[1000001], bonus[1000001];

void inserare(int nod, int st, int dr, int poz, int elem)
{
    if (poz < st || poz > dr)
        return;

    if (st == dr)
    {
        arbore[nod] = elem;
        return;
    }

    if ((st+dr)/2 >= poz)
        inserare(nod*2, st, (st+dr)/2, poz, elem);
    else inserare(nod*2+1, (st+dr)/2+1, dr, poz, elem);

    if (arbore[nod*2] + bonus[nod*2] > arbore[nod*2+1] + bonus[nod*2+1])
        arbore[nod] = arbore[nod*2] + bonus[nod*2];
    else arbore[nod] = arbore[nod*2+1] + bonus[nod*2+1];
}

void punctebonus(int nod, int st, int dr, int lims, int limd, int bns)
{
    if (limd < st || lims > dr)
        return;

    if (lims <= st && dr <= limd)
    {
        bonus[nod] += bns;
        return;
    }

    punctebonus(nod*2, st, (st+dr)/2, lims, limd, bns);
    punctebonus(nod*2+1, (st+dr)/2+1, dr, lims, limd, bns);

    if (arbore[nod*2] + bonus[nod*2] > arbore[nod*2+1] + bonus[nod*2+1])
        arbore[nod] = arbore[nod*2] + bonus[nod*2];
    else arbore[nod] = arbore[nod*2+1] + bonus[nod*2+1];
}

int maxim(int nod, int st, int dr, int lims, int limd)
{
    if (lims > dr || limd < st)
        return 0;

    if (lims <= st && dr <= limd)
        return arbore[nod] + bonus[nod];

    int x = maxim(nod*2, st, (st+dr)/2, lims, limd);
    int y = maxim(nod*2+1, (st+dr)/2+1, dr, lims, limd);
    if (x > y)
        return x + bonus[nod];
    else return y + bonus[nod];
}

void citire()
{
    citeste >> n;
    citeste >> m;
    for (int i = 1; i<=n; i++)
    {
        citeste >> element;
        inserare(1, 1, n, i, element);
    }
    for (int i=1; i<=m; i++)
    {
        citeste >> operatie >> a >> b;
        if (operatie == 1)
        {
            scrie << maxim(1, 1, n, a, b) << '\n';
        }
        else if (operatie == 2)
        {
            citeste >> bns;
            punctebonus(1, 1, n, a, b, bns);
        }
    }
}

int main()
{
    citire();
    return 0;
}
