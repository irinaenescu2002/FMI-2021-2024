#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

ifstream citeste("cuvinte.in");
ofstream scrie("cuvinte.out");

/// Modific forma de salvare a listei de adiacenta pentru a sorta mai usor
/// legaturile dupa cost:
/// -- [(cost, (nod1, nod2)), (cost, (nod1, nod2)) ...];

int k, poz;
string cuvant;
vector <string> cuvinte;
vector <pair <int, pair <int, int>>> lista_adiacenta;
vector <int> parinte, inaltime;

void citire()
{
    /// Salvam cuvintele intr-un vector pentru a le prelucra ulterior.

    while (citeste >> cuvant)
        cuvinte.push_back(cuvant);

    cin >> k;

    inaltime.assign(cuvinte.size(), 0);
    parinte.resize(cuvinte.size());

    /// Punem fiecare cuvant intr-o multime.

    for(int i=0; i<cuvinte.size(); i++)
        parinte[i] = i;
}

/// Functie care calculeaza distanta Levenshtein dintre doua cuvinte,
/// conform indicatiilor si explicatiilor din cursul 5:

/// c[i][j] = numarul minim de operatii de inserare, stergere, modificare pentru a transforma x1...xi în y1...yj
/// Relatii de recurenta:
/// ---- xi = yj :(x1...xi-1 => y1...yj-1) + pastram xi
/// ---- (x1...xi-1 => y1...yj) + stergemxi
/// ---- (x1...xi-1 => y1...yj-1) + modificam xi <-> yj
/// ---- (x1...xi => y1...yj-1) + inseram yj

/// In final, raspunsul se va afla in c[lungime_sir_1][lungime_sir_2].

int distanta_levenshtein(string &s, string &t)
{
    auto lungime_s = s.size();
    auto lungime_t = t.size();
    int mat[lungime_s + 1][lungime_t + 1];

    for (int i=0; i<=lungime_t; i++)
        mat[0][i] = i;
    for (int i=0; i<=lungime_s; i++)
        mat[i][0] = i;

    for (int i=1; i<=lungime_s; i++)
        for (int j=1; j<=lungime_t; j++)
        {
            if (s[i-1] == t[j-1])
                mat[i][j] = mat[i-1][j-1];
            else mat[i][j] = 1 + min({mat[i-1][j], mat[i-1][j-1], mat[i][j-1]});
        }

    return mat[lungime_s][lungime_t];
}

/// Formam lista de adiacenta dintre cuvinte calculand distanta levenshtein dintre ele,
/// Sortam lista pentru a avea la inceput costurile minime.

void atribuire_distante()
{
    for (int i=0; i<cuvinte.size(); i++)
        for (int j=i+1; j<cuvinte.size(); j++)
            lista_adiacenta.push_back({distanta_levenshtein(cuvinte[i], cuvinte[j]), {i, j}});

    sort(lista_adiacenta.begin(), lista_adiacenta.end());
}

/// Functie de cautare a radacinii pentru algoritmul lui Kruskal.

int cautare_radacina(int nod)
{
    if (parinte[nod] != nod)
        parinte[nod] = cautare_radacina(parinte[nod]);
    return parinte[nod];
}

/// Functia de reuniune a doua multimi pentru algoritmul lui Kruskal.

void reuniune (int x, int y)
{
    auto radacinax = cautare_radacina(x);
    auto radacinay = cautare_radacina(y);
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

/// Aplicam algoritmul lui Kruskal pe lista de adiacenta formata anterior.
/// In momentul in care am impartit deja cuvintele in k clase oprim
/// rularea algoritmului si salvam pozitia la care am ajuns in parcurgere.
/// Aceasta ne va ajuta ulterior la gasirea gradului de separare al claselor.

void kruskal ()
{
    int lungime = cuvinte.size();
    for (int i=0; i<lista_adiacenta.size(); i++)
    {
        if (cautare_radacina(lista_adiacenta[i].second.first) != cautare_radacina(lista_adiacenta[i].second.second))
        {
            reuniune(lista_adiacenta[i].second.first, lista_adiacenta[i].second.second);
            lungime --;
            if (lungime == k)
            {
                poz = k;
                break;
            }
        }
    }
}

/// Afisam cuvintele in functie de multimea in care le-am pus, raportandu-ne la
/// radacina arborelui. De asemenea, afisam si gradului de separare al claselor.
/// Pornind de la pozitia salvata anterior, cautam punctul in care se schimba radacinile
/// arborilor si afisam costul minim (datorita ordonarii, acesta este primul gasit).

void afisare()
{
    for (int i=0; i<cuvinte.size(); i++)
    {
        if (parinte[i] == i)
        {
            for(int j=0; j<cuvinte.size(); j++)
            {
                if (cautare_radacina(j) == i)
                    scrie << cuvinte[j] << " ";

            }
            scrie << endl;
        }
    }

    for (int i=poz; i<lista_adiacenta.size(); i++)
    {
        if (cautare_radacina(lista_adiacenta[i].second.first) != cautare_radacina(lista_adiacenta[i].second.second))
        {
            scrie << lista_adiacenta[i].first;
            break;
        }
    }
}

int main()
{
    citire();
    atribuire_distante();
    kruskal();
    afisare();
    return 0;
}
