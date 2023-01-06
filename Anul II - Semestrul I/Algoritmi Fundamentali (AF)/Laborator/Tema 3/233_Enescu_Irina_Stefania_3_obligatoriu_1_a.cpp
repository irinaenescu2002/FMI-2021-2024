/// Complexitate: O(n*m*m)

#pragma GCC optimize "O3"
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

ifstream citeste("maxflow.in");
ofstream scrie("maxflow.out");

int n, m, x, y, capacitate, mat[1001][1001], maxflow;
queue <int> coada;
bool vizitat[1001];
int tata[1001];

/// Faptul ca am declarat matricea grafului global imi asigura faptul
/// ca am muchii reziduale de intoarcere = 0 pentru fiecare muchie
/// pe care o voi citi ulterior din fisier. Pe restul nu le bag in seama.

void citire()
{
    citeste >> n >> m;
    for(int i=0; i<m; i++)
    {
        citeste >> x >> y >> capacitate;
        mat[x][y] = capacitate;
    }
}

inline int bfs()
{
    /// Reinitializez coada, multimea nodurilor vizitate si vectorul de tati
    /// pentru fiecare parcurgere BFS, mai exact pentru fiecare drum.

    while (coada.empty() == false)
        coada.pop();

    for (int i=0; i<=n; i++)
    {
        tata[i] = 0;
        vizitat[i] = false;
    }

    /// Nodul 1 este nodul sursa.

    coada.push(1);
    vizitat[1] = 1;

    /// Fac BFS pentru a gasi drum de la sursa la destinatie:
    /// -- ma uit la vecinii care nu sunt vizitati si au valoarea pozitiva (pot trimite flux)
    /// -- salvez la fiecare pas parintele fiecarui nod pentru a reconstrui drumul

    while (coada.empty() == false)
    {
        auto nod = coada.front();
        coada.pop();

        /// Daca am ajuns la destinatie (nodul destinatie este vizitat), am putut gasi drum.

        if (nod == n) return true;

        for (int i=1; i<=n; i++)
            if (vizitat[i] == false && mat[nod][i] > 0)
            {
                coada.push(i);
                tata[i] = nod;
                vizitat[i] = true;
            }
    }

    /// Daca nu am ajuns la destinatie, nu am putut gasi drum.

    return false;
}

/// Pentru 100 de puncte trebuie facuta o optimizare.
/// Astfel, la fiecare pas construim arborele BFS (excluzand destinatia),
/// si acum un drum de la sursa la destinatie e reprezentat de un drum de la sursa
/// (care este radacina arborelui) la o frunza legata de destinatie printr-o muchie nesaturata.

inline int flux()
{
    /// Cat timp mai putem construi drumuri:

    while (bfs())
    {
        for (int i=1; i<n; i++)
        {
            if (mat[i][n] > 0 && vizitat[i] == true)
            {
                int frunza = i;

                /// Reconstitui drumul dupa vectorul de tati:

                vector <int> drum;
                drum.push_back(n);
                drum.push_back(frunza);

                int nod = tata[frunza];

                if (nod == 1)
                    drum.push_back(nod);
                else
                {
                    while (nod != 1)
                    {
                        drum.push_back(nod);
                        nod = tata[nod];
                    }
                    drum.push_back(1);
                }

                reverse(drum.begin(), drum.end());

                /// Gasesc capacitatea minima si o adaug la flux.

                int capacitate_minima = 110001;

                for(long unsigned int i=0; i<drum.size()-1; i++)
                    capacitate_minima = min(capacitate_minima, mat[drum[i]][drum[i+1]]);

                maxflow += capacitate_minima;

                /// Capacitatea minima:
                /// -- o scad din muchiile drumului
                /// -- o adaug la muchiile cu directie opusa

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
    scrie << flux();
    return 0;
}
