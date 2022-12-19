#include <iostream>
#include <fstream>
#include <vector>
#include <iomanip>
#include <queue>

#define infinit 1e9 + 1

using namespace std;

ifstream citeste("ciclu.in");
ofstream scrie("ciclu.out");

/// Complexitate: O(n*m)

int n, m, x, y;
double c, valoare_maxima, stanga, dreapta, mijloc, raspuns, cost_curent_interval;
bool avem_ciclu_bun;
vector <vector <pair <int, double>>> lista_adiacenta;

void citire()
{
    citeste >> n >> m;
    lista_adiacenta.resize(n+1);

    for (int i=0; i<m; i++)
    {
        citeste >> x >> y >> c;

        /// Intrucat nu putem face cautare binara pe numere cu virgula,
        /// le transformam in numere intregi.

        double cost_int = c*100;
        lista_adiacenta[x].push_back({y, cost_int});
    }

    /// Adunam toate costurile pentru a retine valoarea maxima a
    /// intervalului cautarii binare (un cost mediu minim al ciclului
    /// nu poate depasi suma tuturor costurilor).

    for (long unsigned int i=0; i<lista_adiacenta.size(); i++)
        for (long unsigned int j=0; j<lista_adiacenta[i].size(); j++)
            valoare_maxima += lista_adiacenta[i][j].second;

    /// Pentru a evita cazul in care graful nu este conex adaug un nod auxiliar 0
    /// si muchii cu cost 0 pana la fiecare nod al grafului.

    for (int i=1; i<=n; i++)
        lista_adiacenta[0].push_back({i, 0});
}

void bellman_ford (double cost_curent_interval)
{
    /// Folosim urmatorii vectori:
    /// ---> coada retine nodurile parcurgerii
    /// ---> este_in_coada retine daca un nod este sau nu in coada
    /// ---> contor_noduri retine de cate ori am actualizat distanta fiecarui nod;
    /// ---> costuri retine costurile calculate pentru fiecare nod
    /// Ii declar direct in functie deoarece trebuie reinitializati pentru fiecare aplicare a algoritmului.

    queue <int> coada;
    vector <bool> este_in_coada(n+1, false);
    vector <int> contor_noduri(n+1, 0);
    vector <double> costuri(n+1, infinit);

    /// Pornim de la nodul auxiliar, nodul 0.

    coada.push(0);
    este_in_coada[0] = true;
    costuri[0] = 0;

    /// Cat timp mai sunt noduri de prelucrat in coada:

    while (coada.empty() == false)
    {
        /// Extragem primul nod din coada.

        auto nod_extras = coada.front();
        coada.pop();
        este_in_coada[nod_extras] = false;

        /// Pentru fiecare vecin al sau:

        for (long unsigned int i=0; i<lista_adiacenta[nod_extras].size(); i++)
        {
            auto nod_vecin = lista_adiacenta[nod_extras][i].first;
            auto cost_vecin = lista_adiacenta[nod_extras][i].second;

            /// Am modificat putin conditia algoritmului Bellman-Ford, scazand din costul muchiei
            /// costul curent din interval. Acesta este o posibila solutie in cazul in care se
            /// genereaza un ciclu negativ. Cautam asadar sa ajungem pe -.

            if (costuri[nod_extras] + cost_vecin - cost_curent_interval < costuri[nod_vecin])
            {
                costuri[nod_vecin] = costuri[nod_extras] + cost_vecin - cost_curent_interval;

                /// Daca vecinul nu este deja in coada:

                if (este_in_coada[nod_vecin] == false)
                {
                    /// Il adaugam in coada.

                    coada.push(nod_vecin);
                    este_in_coada[nod_vecin] = true;
                    contor_noduri[nod_vecin] ++;

                    /// In cazul in care este actualizat de n ori, am gasit un ciclu,
                    /// altfel continuam algoritmul.

                    if (contor_noduri[nod_vecin] >= n)
                    {
                        avem_ciclu_bun = true;
                        return;
                    }
                }
            }
        }
    }
}

void cautare_binara()
{
    while (stanga <= dreapta)
    {
        mijloc = (stanga + dreapta)/2;

        /// Daca costul curent nu imi genereaza un ciclu cautam unul cu o valoare mai mare.
        /// Daca imi genereaza un ciclu, cautam unul cu o valoare mai mica in speranta
        /// de a-l minimiza.

        avem_ciclu_bun = false;
        bellman_ford(mijloc);
        if (avem_ciclu_bun == false)
            stanga = mijloc + 1;
        else
            dreapta = mijloc - 1;
    }

    /// In final, costul cel mai mic se va afla la capatul stang al intervalului.

    raspuns = stanga;
}

int main()
{
    citire();
    stanga = 0;
    dreapta = valoare_maxima;
    cautare_binara();
    scrie << fixed << setprecision(2) << raspuns/100;
    return 0;
}
