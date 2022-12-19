#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

/// Complexitate: O(mlogn)

ifstream citeste("apm2.in");
ofstream scrie ("apm2.out");

/// Modific forma de salvare a listei de adiacenta pentru a sorta mai usor
/// legaturile dupa cost:
/// -- [(cost, (nod1, nod2)), (cost, (nod1, nod2)) ...];

int n, m, q, x, y, t, inaltime[100001], parinte[100001], radacinax, radacinay, taxa_apm;
vector <pair <int, pair<int, int>>> lista_adiacenta, apm;
vector <pair <int, int>> drumuri_noi;
vector<int> costuri;

/// Salvez graful initial intr-o lista de adiacenta si
/// drumurile adaugate ulterior intr-un vector.
/// Sortez muchiile dupa cost pentru a le selecta mai intai pe cele minime.

void citire ()
{
    citeste >> n >> m >> q;

    for (int i=0; i<m; i++)
    {
        citeste >> x >> y >> t;
        lista_adiacenta.push_back({t, {x, y}});
    }

    sort(lista_adiacenta.begin(), lista_adiacenta.end());

    for (int i=0; i<q; i++)
    {
        citeste >> x >> y;
        drumuri_noi.push_back({x, y});
    }
}

/// Pun fiecare nod intr-o multime ce are la inceput inaltimea 0.

void multimi_initiale()
{
    for (int nod=1; nod<=n; nod++)
        parinte[nod] = nod;

    for(int nod=1; nod<=n; nod++)
        inaltime[nod] = 0;
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

/// Aplicam algoritmul lui Kruskal pe lista de adiacenta formata anterior,
/// obtinand astfel APM-ul grafului.

void kruskal ()
{
    multimi_initiale();

    for (int i=0; i<m; i++)
    {
        auto taxa = lista_adiacenta[i].first;
        auto x = lista_adiacenta[i].second.first;
        auto y = lista_adiacenta[i].second.second;

        radacinax = cautare_radacina(x);
        radacinay = cautare_radacina(y);

        if (radacinax != radacinay)
        {
            reuniune(radacinax, radacinay);
            apm.push_back({taxa, {x, y}});
            taxa_apm += taxa;
        }
    }
}

/// Pentru fiecare drum nou adaugat de Marele Lider, aplicam iar algoritmul
/// lui Kruskal pentru a gasi al doilea APM.

void kruskal2 ()
{
    for(long unsigned int i=0; i<drumuri_noi.size(); i++)
    {
        /// Avem grija sa reinitializam multimile si inaltimile nodurilor.

        multimi_initiale();

        int taxa_apm2 = 0;

        auto drum = drumuri_noi[i];
        auto x = drum.first;
        auto y = drum.second;

        /// Adaugam practic o noua muchie cu cost 0 prin reuniunea celor
        /// doua capete ale oraselor.

        reuniune(x, y);

        /// Facem iar Kruskal, dar de data aceasta pornim deja cu o muchie
        /// inclusa in APM, cea de cost 0 dintre orasele precizate de Marele Lider.

        for(long unsigned int i=0; i<apm.size(); i++)
        {
            auto drum = apm[i];
            auto taxa = drum.first;
            auto x = drum.second.first;
            auto y = drum.second.second;

            radacinax = cautare_radacina(x);
            radacinay = cautare_radacina(y);

            if (radacinax != radacinay)
            {
                reuniune(radacinax, radacinay);
                taxa_apm2 += taxa;
            }
        }

        /// La final, (diferenta dintre cele doua APM-uri - 1) va fi
        /// valoarea maxima pe care o poate lua muchia cu cost 0 astfel incat sa
        /// apara sigur in APM.

        costuri.push_back(taxa_apm - taxa_apm2 - 1);
    }
}

void afisare ()
{
    for (long unsigned int i=0; i<costuri.size(); i++)
        scrie << costuri[i] << "\n";
}

int main()
{
    citire();
    kruskal();
    kruskal2();
    afisare();
    return 0;
}
