#include <iostream>
#include <fstream>

using namespace std;

ifstream citeste("curatenie.in");
ofstream scrie("curatenie.out");

int membrii;
int srd[500001], rsd[500001], poz[500001];
int index;
int fs[500001], fd[500001];


void citire()
{
    citeste >> membrii;

    for (int i=1; i<=membrii; i++)
    {
        citeste >> srd[i];
        poz[srd[i]] = i;
    }

    for (int i=1; i<=membrii; i++)
        citeste >> rsd[i];
}

void afisare ()
{
    for(int i=1; i<=membrii; i++)
        scrie << fs[i] << " " << fd[i] << "\n";
}

int parcurgere(int stanga, int dreapta)
{
    if (stanga > dreapta)
        return 0;

    index ++;
    int pozelem = index;

    if (stanga == dreapta)
        return rsd[pozelem];

    fs[rsd[pozelem]] = parcurgere(stanga, poz[rsd[pozelem]]-1);
    fd[rsd[pozelem]] = parcurgere(poz[rsd[pozelem]]+1, dreapta);

    return rsd[pozelem];
}


int main()
{
    citire();
    parcurgere(1, membrii);
    afisare();
    return 0;
}

