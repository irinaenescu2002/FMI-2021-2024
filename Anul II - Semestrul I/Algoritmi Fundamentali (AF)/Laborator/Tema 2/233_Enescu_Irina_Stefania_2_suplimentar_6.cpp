#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <queue>

#define maxn 51
#define maxk 1001
#define infinit 1e9 + 1

using namespace std;

/// Complexitate: O(n*m)

ifstream citeste("lanterna.in");
ofstream scrie("lanterna.out");

int n, k, m, a, b, T, W, raspuns_timp, raspuns_watti;
vector <int> baze_prietene, drum;
vector < vector <vector <int>>> lista_adiacenta(maxn);
vector <int> watti_consumati(maxn, infinit);
priority_queue <vector <int>, vector <vector <int>>, greater <vector <int>>> coada;

void citire()
{
    citeste >> n >> k;

    /// Citim bazele (nu exista o baza cu index 0, deci punem o valoare arbitrara).

    baze_prietene.push_back(-1);
    for (int i=0; i<n; i++)
    {
        int var;
        citeste >> var;
        baze_prietene.push_back(var);
    }

    /// Salvam drumurile sub forma unui vector de tipul:
    /// [timp, watti, nod plecare, nod destinatie] deoarece vrem sa fie ordonat
    /// crescator dupa timp si watti si asa este mai convenabil de lucrat cu el.

    citeste >> m;
    for (int i=0; i<m; i++)
    {
        citeste >> a >> b >> T >> W;

        drum.clear();
        drum.push_back(b);
        drum.push_back(T);
        drum.push_back(W);

        lista_adiacenta[a].push_back(drum);

        drum.clear();
        drum.push_back(a);
        drum.push_back(T);
        drum.push_back(W);

        lista_adiacenta[b].push_back(drum);
    }
}

void dijkstra()
{
    /// Drumul are urmatoarea legenda:
    /// --> timpul minim necesar ajungerii la baza curenta
    /// --> numarul de watti consumati pana la baza curenta
    /// --> numarul maxim de watti consumati de la baza 1 (acestia ne dau la final valoarea minima a bateriei lanternei)
    /// --> baza curenta

    /// Incepem parcurgerea cu timpul, numarul de watti consumati si numarul
    /// maxim de watti consumati 0 pornind de la nodul 1.

    drum.clear();
    drum.push_back(0);
    drum.push_back(0);
    drum.push_back(0);
    drum.push_back(1);

    coada.push(drum);

    while (coada.empty() == false)
    {
        /// Extragem drumul cu timpii si watii minimi.

        auto drum_extras = coada.top();
        coada.pop();
        auto timp_curent = drum_extras[0];
        auto watti_consumati_curent = drum_extras[1];
        auto maxwatti_consumati_curent = drum_extras[2];
        auto nod_curent = drum_extras[3];

        /// Incercam sa minimizam numarul de watti consumati in functie de
        /// ce avem in vectorul de watti:

        if (watti_consumati_curent < watti_consumati[nod_curent])
        {
            watti_consumati[nod_curent] = watti_consumati_curent;

            /// Daca suntem la o baza prietena incarcam lanterna, deci consumul
            /// curent de watti devine 0.

            if (baze_prietene[nod_curent] == 1)
                watti_consumati_curent = 0;

            /// Daca am ajuns la destinatie salvam timpul minim si consumul
            /// maxim de watti cummulati pe parcurs (valoarea minima a lanternei). Oprim algoritmul.

            if (nod_curent == n)
            {
                raspuns_timp = timp_curent;
                raspuns_watti = maxwatti_consumati_curent;
                return;
            }

            /// Pentru fiecare vecin al nodului curent:

            for (long unsigned int i=0; i<lista_adiacenta[nod_curent].size(); i++)
            {
                auto drum_vecin_extras = lista_adiacenta[nod_curent][i];
                auto nod_vecin = drum_vecin_extras[0];
                auto timp_vecin = drum_vecin_extras[1];
                auto watti_consumati_vecin = drum_vecin_extras[2];

                /// Daca putem actualiza si avem disponibila o lanterna sa suporte numarul de watti necesari:

                if (watti_consumati_curent + watti_consumati_vecin < watti_consumati[nod_vecin] && watti_consumati_curent + watti_consumati_vecin <= k)
                {
                    /// Adaugam o noua posibilitate de drum in coada.

                    drum.clear();
                    drum.push_back(timp_curent + timp_vecin);
                    drum.push_back(watti_consumati_curent + watti_consumati_vecin);
                    drum.push_back(max(maxwatti_consumati_curent, watti_consumati_curent + watti_consumati_vecin));
                    drum.push_back(nod_vecin);

                    coada.push(drum);

                    /// Reluam actualizarile pana coada e goala.
                }
            }
        }
    }
}

int main()
{
    citire();
    dijkstra();
    scrie << raspuns_timp << " " << raspuns_watti;
    return 0;
}
