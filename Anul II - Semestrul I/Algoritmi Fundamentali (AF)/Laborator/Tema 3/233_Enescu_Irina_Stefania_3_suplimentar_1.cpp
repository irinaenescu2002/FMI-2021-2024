/// Complexitate: O(n * logn * m^2)

#include <iostream>
#include <fstream>
#include <queue>
#include <vector>

#define infinit 1e9

using namespace std;

ifstream citeste("fmcm.in");
ofstream scrie("fmcm.out");

/// Folosesc trei vectori de costuri:
/// - vectorul pentru costurile Bellman pentru a trata costurile negative
/// - vectorul pentru costurile Dijkstra cu proprietatea de optimizare aplicata
/// - vectorul pentru costurile propriu zise ale drumurilor

int n, m, s, d, x, y, flux, costt, mat[351][351], cost[351][351], tata[351], rasp_cost, rasp_flux;
vector <vector <int>> lista_adiacenta(351);
vector <int> costuriBellman(351), costuriDijkstra(351), costuri(351);

void citire()
{
    citeste >> n >> m >> s >> d;

    /// Pentru fiecare arc x -> y de cost z din graful initial adaug
    /// in graful rezidual arcul y -> x cu capacitatea 0 (asigurata de
    /// declararea globala a matricei) si costul -z.

    for (int i=0; i<m; i++)
    {
        citeste >> x >> y >> flux >> costt;
        lista_adiacenta[x].push_back(y);
        lista_adiacenta[y].push_back(x);
        mat[x][y] = flux;
        cost[x][y] = costt;
        cost[y][x] = -costt;
    }
}

/// ------------- PASUL 1 ------------------------------------------------------------

/// Pentru a gasi drumul de ameliorare optim din punct de vedere al costului
/// folosesc un algoritm de drum minim care sa permita existenta costurilor
/// negative pe arce (costurile arcelor de intoarcere) - Bellman-Ford.

/// Daca folosim doar Bellman-Ford avem o complexitate O(n^2 * m^2), complexitate pe
/// care o vom imbunatati ulterior la O(n * logn * m^2) cu Dijkstra.

/// Implementare Bellman-Ford:

void bellman_ford ()
{
    queue <int> coada;
    vector <bool> este_in_coada(351, false);
    costuriBellman.assign(351, infinit);

    coada.push(s);
    este_in_coada[s] = true;
    costuriBellman[s] = 0;

    while (coada.empty() == false)
    {
        auto nod_extras = coada.front();
        coada.pop();
        este_in_coada[nod_extras] = false;

        for (long unsigned int i=0; i<lista_adiacenta[nod_extras].size(); i++)
        {
            auto nod_vecin = lista_adiacenta[nod_extras][i];
            auto cost_vecin = cost[nod_extras][nod_vecin];
            auto flux_vecin = mat[nod_extras][nod_vecin];

            /// In plus, ma asigur ca exista flux pe muchia respectiva.

            if (flux_vecin != 0)
            {
                if (costuriBellman[nod_vecin] > costuriBellman[nod_extras] + cost_vecin)
                {
                    costuriBellman[nod_vecin] = costuriBellman[nod_extras] + cost_vecin;
                    if (este_in_coada[nod_vecin] == false)
                    {
                        coada.push(nod_vecin);
                        este_in_coada[nod_vecin] = true;
                    }
                }
            }
        }
    }
}

/// ------------- PASUL 2 ------------------------------------------------------------

/// Pentru a imbunatati algoritmul de mai sus, atunci cand caut drumul de ameliorare
/// de cost minim folosesc algoritmul lui Dijkstra, dar inainte graful trebuie modificat
/// astfel incat sa nu mai exista arce cu cost negativ.

/// Initial, folosind algoritmul lui Bellman-Ford, calculam valorile vectorului de costuriBellman (in main).
/// Apoi, fiecarui arc x -> y de cost z i se va asocia costul [z + costB(x) - costB(y)] in vectorul de costuriDijkstra.
/// Astfel, costul arcelor devine pozitiv si putem aplica Dijkstra.

/// In vectorul costuri pastrez costurile efective ale distantelor parcurse.

/// Implementare Dijkstra:

void dijkstra ()
{
    priority_queue <pair <int, int>, vector <pair <int, int>>, greater <pair <int, int>>> coada;
    costuriDijkstra.assign(351, infinit);

    costuriDijkstra[s] = 0;
    costuri[s] = 0;
    coada.push({0, s});

    while(coada.empty() == false)
    {
        auto pereche_extrasa = coada.top();
        coada.pop();

        auto cost_extras = pereche_extrasa.first;
        auto nod_extras = pereche_extrasa.second;

        if (costuriDijkstra[nod_extras] == cost_extras)
            for (unsigned long int j=0; j<lista_adiacenta[nod_extras].size(); j++)
            {
                auto vecin = lista_adiacenta[nod_extras][j];
                auto cost_vecin = cost[nod_extras][vecin];
                auto flux_vecin = mat[nod_extras][vecin];

                /// In plus, ma asigur ca exista flux pe muchia respectiva.

                if (flux_vecin > 0)
                    if (costuriDijkstra[vecin] > costuriDijkstra[nod_extras] + cost_vecin + costuriBellman[nod_extras] - costuriBellman[vecin])
                    {
                        /// Calculez costulDijkstra dupa formula de mai sus.

                        costuriDijkstra[vecin] = costuriDijkstra[nod_extras] + cost_vecin + costuriBellman[nod_extras] - costuriBellman[vecin];
                        coada.push({costuriDijkstra[vecin], vecin});

                        costuri[vecin] = costuri[nod_extras] + cost_vecin;
                        tata[vecin] = nod_extras;
                    }
            }
    }
}


/// ------------- PASUL 3 ------------------------------------------------------------

/// Aplicam Flux:

bool alg_flux()
{
    /// Calculam costurile efective cu Dijkstra.

    dijkstra();

    /// Actualizez pentru fiecare drum costurile Bellman cu cele efective.

    for (int i=1; i<=n; i++)
        costuriBellman[i] = costuri[i];

    /// In cazul in care nu am ajuns la destinatie nu mai exista drumuri.

    if (costuriDijkstra[d] == infinit) return false;

    /// Pornim mereu cu costul 0 si fluxul infinit pentru a adauga costuri,
    /// respectiv a minimiza fluxul.

    int flux_curent = infinit;
    int cost_curent = 0;

    int nod = d;

    /// Pornim invers pentru a ne ajuta de vectorul de tati construit in Dijkstra.
    /// Cat timp nu am ajuns de la destinatie la sursa, cautam fluxul minim si
    /// actualizam costul curent.

    while (nod != s)
    {
        flux_curent = min(flux_curent, mat[tata[nod]][nod]);
        cost_curent += cost[tata[nod]][nod];
        nod = tata[nod];
    }

    /// Actualizam matricea de fluxuri:

    nod = d;

    while (nod != s)
    {
        mat[tata[nod]][nod] -= flux_curent;
        mat[nod][tata[nod]] += flux_curent;
        nod = tata[nod];
    }

    /// Actualizam fluxul total si costul total.

    rasp_cost += flux_curent * costuri[d];
    rasp_flux += flux_curent;

    return true;
}

int main()
{
    citire();
    bellman_ford();
    while (alg_flux());
    scrie << rasp_cost;
    return 0;
}
