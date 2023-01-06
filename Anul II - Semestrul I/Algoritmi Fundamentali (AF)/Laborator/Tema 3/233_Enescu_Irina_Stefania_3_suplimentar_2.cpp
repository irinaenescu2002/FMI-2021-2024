/// Complexitate: O(n*m*m)

#include <iostream>
#include <fstream>
#include <algorithm>
#include <queue>

using namespace std;

ifstream citeste("drumuri2.in");
ofstream scrie("drumuri2.out");

/// Problema se rezuma la a gasi Minimum path cover in directed acyclic graph.

/// Raspunsul este (n - cm), unde n este numarul de noduri, iar cm este cuplajul maxim.

int n, m, x, y, capacitate, mat[1001][1001], maxflow;
queue <int> coada;
bool vizitat[1001];
int tata[1001];

/// Pentru a determina cuplajul maxim voi transforma graful intr-un graf bipartit cu o retea de transport
/// adaugand un nod sursa si un nod destinatie. Pe toate muchiile voi pune capacitate 1.

void citire()
{
    citeste >> n >> m;
    for(int i=0; i<m; i++)
    {
        citeste >> x >> y;

        /// Trebuie sa dublam nodurile pentru a adauga muchii, asadar
        /// adaug noduri in continuarea lui n.

        mat[x][y+n] = 1;
    }

    /// Consider nodul sursa = 0 si adaug muchii de la el pe prima multime.

    for (int i=0; i<=n; i++)
        mat[0][i] = 1;

    /// Consider nodul destinatie 202 (deoarece putem avea 100 noduri, dublate 200)
    /// si adaug muchii spre el din a doua multime.

    for (int j=1; j<=n; j++)
        mat[j+n][202] = 1;

    /// Adaug muchii si de la nodurile dublate la cele initiale pentru a putea
    /// avea drumuri mai lungi decat cele standard 0 - nod - nod - 202

    for (int j=1; j<=n; j++)
        mat[j+n][j] = 1;
}


/// Functie de parcurgere pentru algoritmul flux.

inline int bfs()
{
    while (coada.empty() == false)
        coada.pop();

    for (int i=0; i<=202; i++)
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

        if (nod == 202) return true;

        for (int i=1; i<=202; i++)
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
            if (mat[i][202] > 0 && vizitat[i] == true)
            {
                int frunza = i;

                vector <int> drum;
                drum.push_back(202);
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


int main()
{
    citire();
    scrie << n - flux() << endl;
    return 0;
}
