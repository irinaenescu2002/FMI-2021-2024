#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

/// Complexitate: O(k(n+m))

ifstream citeste("online.in");
ofstream scrie("online.out");

/// Modific forma de salvare a listei de adiacenta pentru a sorta mai usor
/// legaturile dupa cost:
/// -- [(cost, (nod1, nod2)), (cost, (nod1, nod2)) ...];

int n, m, x, y, c, k, inaltime[100001], parinte[100001], radacinax, radacinay;
vector <pair <int, pair<int, int>>> lista_adiacenta, apm, drumuri_noi;
long long cost_apm, cost_anterior;
vector <long long> costuri;


/// Salvez graful initial intr-o lista de adiacenta si
/// drumurile adaugate ulterior intr-un vector.
/// Sortez muchiile dupa cost pentru a le selecta mai intai pe cele minime.

void citire ()
{
    citeste >> n >> m;

    for (int i=0; i<m; i++)
    {
        citeste >> x >> y >> c;
        lista_adiacenta.push_back({c, {x, y}});
    }

    citeste >> k;

    for (int i=0; i<k; i++)
    {
        citeste >> x >> y >> c;
        drumuri_noi.push_back({c, {x, y}});
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

/// Aplicam algoritmul lui Kruskal pe lista de adiacenta,
/// obtinand astfel APM-ul grafului curent.

void kruskal ()
{
    multimi_initiale();
    cost_apm = 0;

    sort(lista_adiacenta.begin(), lista_adiacenta.end());

    for (int i=0; i<lista_adiacenta.size(); i++)
    {
        auto cost = lista_adiacenta[i].first;
        auto x = lista_adiacenta[i].second.first;
        auto y = lista_adiacenta[i].second.second;

        radacinax = cautare_radacina(x);
        radacinay = cautare_radacina(y);

        if (radacinax != radacinay)
        {
            reuniune(radacinax, radacinay);
            apm.push_back({cost, {x, y}});
            cost_apm += cost;
        }
    }

    /// Afisam costul curent.

    scrie << cost_apm << "\n";
    cost_anterior = cost_apm;
}

/// Facem Kruskal incluzand pe rand noile muchii.

void kruskal2 ()
{
    for(long unsigned int i=0; i<drumuri_noi.size(); i++)
    {
        auto cmmare_cost = lista_adiacenta[lista_adiacenta.size()-1].first;
        auto cost_curent = drumuri_noi[i].first;

        /// Daca merita sa luam in considerare noua muchie (daca este mai mica
        /// decat cel mai mare cost din proiectul anterior), o adaugam.
        /// Daca nu, costul nu se modifica.

        if (cost_curent < cmmare_cost)
        {
            /// Noua lista de adiacenta a grafului va fi reprezentata de APM-ul
            /// construit anterior.

            lista_adiacenta = apm;

            /// Stergem tot din APM pentru a-l pregati pentru recalculare.

            apm.clear();

            /// Adaugam muchia noua in lista de adiacenta.

            lista_adiacenta.push_back({drumuri_noi[i].first, {drumuri_noi[i].second.first, drumuri_noi[i].second.second}});

            /// Facem din nou Kruskal pentru noua lista de adiacenta.

            kruskal();
        }
        else scrie << cost_anterior << "\n";
    }
}

int main()
{
    citire();
    kruskal();
    kruskal2();
    return 0;
}

