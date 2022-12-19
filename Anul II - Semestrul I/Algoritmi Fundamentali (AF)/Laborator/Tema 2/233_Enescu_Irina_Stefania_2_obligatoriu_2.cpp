/// DISJOINT

/// Complexitate O(log*n)

/// OPERATIA 1 = se dau doua elemente, x si y si se cere reuniunea multimilor din care fac parte
/// OPERATIA 2 = se dau doua elemente, x si y; se gasesc in aceeasi multime?

/// Implementare bazata pe tratarea unei multimi sub forma unui arbore.
/// Radacina fiecarui arbore = reprezentantul fiecarei multimi

#include <iostream>
#include <fstream>

using namespace std;

ifstream citeste("disjoint.in");
ofstream scrie("disjoint.out");

int n, m, x, y, cod, inaltime[100001], parinte[100001], radacinax, radacinay;

/// Introduc fiecare nod intr-un arbore cu un singur nod.

void multimi_initiale()
{
    for (int nod=1; nod<=n; nod++)
        parinte[nod] = nod;
}

/// Pentru un nod curent gasesc recursiv radacina arborelui.

int cautare_radacina(int nod)
{
    if (parinte[nod] != nod)
        parinte[nod] = cautare_radacina(parinte[nod]);
    return parinte[nod];
}

/// Gasesc radacinile aborilor din care fac parte nodurile x si y.
/// In cazul in care ajung la aceeasi radacina, nodurile fac parte din aceeasi multime
/// si nu este nevoie sa reunim nimic.
/// In caz contrar, legam radacinile intre ele pentru a reuni cei doi arbori.
/// Ne punem problema inaltimii arborilor pe care vrem sa i conectam, dorind sa
/// avem un arbore de inaltime minima:
/// -- daca arborele lui x are inaltimea mai mica decat arborele lui y,
///    legam arborele lui x de arborele lui y
/// -- daca arborele lui x are inaltimea mai mare decat arborele lui y,
///    legam arborele lui y de arborele lui x
/// -- daca arborii au aceeasi inaltime, nu conteaza cum ii legam, dar avem grija
///    sa incrementam inaltimea arborelui de care am legat


void reuniune (int x, int y)
{
    radacinax = cautare_radacina(x);
    radacinay = cautare_radacina(y);
    if (radacinax == radacinay) return;
    if (inaltime[radacinax] < inaltime[radacinay])
        parinte[radacinax] = radacinay;
    else if (inaltime[radacinax] > inaltime[radacinay])
        parinte[radacinay] = radacinax;
    else
    {
        parinte[radacinay] = radacinax;
        inaltime[radacinax] ++;
    }
}

/// Daca codul este 1, apelam functia de reuniune a multimilor.
/// Daca codul este 2:
/// -- daca arborii din care fac parte nodurile x si y au aceeasi radacina,
///    atunci se afla in aceeasi multime
/// -- altfel se afla in multimi diferite

void citire ()
{
    citeste >> n >> m;
    multimi_initiale();
    for (int i=1; i<=m; i++)
    {
        citeste >> cod >> x >> y;
        if (cod == 1)
            reuniune(x, y);
        else
        {
            if (cautare_radacina(x) == cautare_radacina(y))
                scrie << "DA" << "\n";
            else scrie << "NU" << "\n";
        }
    }
}

int main()
{
    citire();
    return 0;
}
