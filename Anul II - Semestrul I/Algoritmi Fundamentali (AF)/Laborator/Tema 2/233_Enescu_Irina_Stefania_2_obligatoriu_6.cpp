/// EasyGraph
/// Complexitate: O(n)

#include <iostream>
#include <vector>
#include <fstream>
#include <set>

using namespace std;

ifstream citeste("easygraph.in");
ofstream scrie("easygraph.out");

long long nr_teste, n, m, x, y;
vector <vector <long long>> lista_adiacenta;
vector <bool> vizitat;
vector <long long> costuri;
vector <long long> costuri_maxime;
set <long long> multime_costuri;

void dfs (long long nod_start)
{
    vizitat[nod_start] = true;
    costuri_maxime[nod_start] = costuri[nod_start];
    for(long unsigned int i=0; i<lista_adiacenta[nod_start].size(); i++)
    {
        if (vizitat[lista_adiacenta[nod_start][i]] == false)
            dfs(lista_adiacenta[nod_start][i]);

        /// Dupa ce am parcurs recursiv vecinii, ajungand sa formam un lant, actualizam costul.
        /// In cazul in care obtinem un cost mai mare mergand la vecinul nodului curent, o facem.
        /// Noul cost va fi egal cu suma dintre costul nodului curent si costul maxim al vecinului.

        costuri_maxime[nod_start] = max(costuri_maxime[nod_start], costuri[nod_start] + costuri_maxime[lista_adiacenta[nod_start][i]]);
    }
}

void citire ()
{
    citeste >> nr_teste;
    for (int i=0; i<nr_teste; i++)
    {
        citeste >> n >> m;

        /// Reinitializam multimea de costuri, lista de adiacenta, vectorul de vizitat, vectorul
        /// de costuri si vectorul de costuri maxime pentru fiecare test.

        multime_costuri.clear();
        lista_adiacenta.clear();
        lista_adiacenta.resize(n+1);
        vizitat.clear();
        vizitat.assign(n+1, false);
        costuri.clear();
        costuri.resize(n+1);
        costuri_maxime.clear();
        costuri_maxime.assign(n+1, -1e9);

        /// Citim costurile nodurilor.

        for (int i=1; i<=n; i++)
            citeste >> costuri[i];

        /// Compunem lista de adiacenta a grafului.

        for (int i=1; i<=m; i++)
        {
            citeste >> x >> y;
            lista_adiacenta[x].push_back(y);
        }

        /// Facem o parcurgere DFS pentru a memora pentru fiecare
        /// nod costul maxim obtinut in cazul in care se pleaca din el.

        for(int nod=1; nod<=n; nod++)
            if (vizitat[nod] == false)
                dfs(nod);

        /// Introduc toate costurile maxime intr-o multime pentru a-l extrage
        /// pe cel mai mare usor de la final.

        for (int nod=1; nod<=n; nod++)
            multime_costuri.insert(costuri_maxime[nod]);

        scrie << *multime_costuri.rbegin() << "\n";
    }
}

int main()
{
    citire();
    return 0;
}
