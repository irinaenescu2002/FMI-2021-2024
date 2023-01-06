/// Complexitate: O(n*m*m)

#pragma GCC optimize "O3"
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

ifstream citeste("cuplaj.in");
ofstream scrie("cuplaj.out");

int n, m, x, y, e, mat[20007][20007], maxflow;
queue <int> coada;
bool vizitat[20007];
int tata[20007];

/// Voi aborda problema asa cum am abordat problema 'Harta'.

/// Pentru a determina cuplajul maxim voi transforma graful bipartit într-o retea de transport
/// adaugand un nod sursa si un nod destinatie. Pe toate muchiile voi pune capacitate 1.

void citire()
{
    citeste >> n >> m >> e;

    for(int i=0; i<e; i++)
    {
        citeste >> x >> y;

        /// Trebuie sa dublam nodurile pentru a adauga muchii, asadar
        /// adaug noduri in continuarea lui n.

        mat[x][y+n] = 1;
    }

    /// Consider nodul sursa = 0 si adaug muchii de la el pe prima multime.

    for (int i=0; i<=n; i++)
        mat[0][i] = 1;

    /// Consider nodul destinatie 20002 (deoarece putem avea 10000 noduri, dublate 20000)
    /// si adaug muchii spre el din a doua multime.

    for (int j=1; j<=m; j++)
        mat[j+n][20002] = 1;
}

/// Functie de parcurgere pentru algoritmul flux.

inline int bfs()
{
    while (coada.empty() == false)
        coada.pop();

    for (int i=0; i<=20002; i++)
    {
        tata[i] = -1;
        vizitat[i] = false;
    }

    coada.push(0);
    vizitat[0] = true;

    while (coada.empty() == false)
    {
        auto nod = coada.front();
        coada.pop();

        if (nod == 20002) return true;

        for (int i=1; i<=20002; i++)
            if (vizitat[i] == false && mat[nod][i] > 0)
            {
                coada.push(i);
                tata[i] = nod;
                vizitat[i] = true;
            }
    }

    return false;
}

/// Algoritmul pentru flux

inline int flux()
{
    while (bfs())
    {
        for (int i=n+1; i<2*n+1; i++)
        {
            if (mat[i][20002] > 0 && vizitat[i] == true)
            {
                int frunza = i;

                vector <int> drum;
                drum.push_back(20002);
                drum.push_back(frunza);

                int nod = tata[frunza];

                if (nod == 0)
                    drum.push_back(nod);
                else
                {
                    while (nod != 0)
                    {
                        drum.push_back(nod);
                        nod = tata[nod];
                    }
                    drum.push_back(0);
                }

                reverse(drum.begin(), drum.end());

                int capacitate_minima = 110001;

                for(long unsigned int i=0; i<drum.size()-1; i++)
                    capacitate_minima = min(capacitate_minima, mat[drum[i]][drum[i+1]]);

                maxflow += capacitate_minima;

                for(long unsigned int i=0; i<drum.size()-1; i++)
                {
                    mat[drum[i]][drum[i+1]] -= capacitate_minima;
                    mat[drum[i+1]][drum[i]] += capacitate_minima;
                }
            }
        }
    }

    return maxflow;
}

void raspuns ()
{
    /// Fluxul maxim = cuplajul maxim

    scrie << maxflow << endl;

    /// Muchiile sunt cele care nu mai au capacitate.

    for (int i=1; i<=n; i++)
        for (int j=1; j<=m; j++)
            if (mat[i][n+j] == 0 && mat[n+j][i] == 1)
                scrie << i << " " << j << endl;
}

int main()
{
    citire();
    flux();
    raspuns();
    return 0;
}
