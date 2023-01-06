/// Complexitate: O(n*m*m)

#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

ofstream scrie("harta.out");
ifstream citeste("harta.in");

int n, m, x, y, capacitate, mat[1001][1001], maxflow, in[1001], out[1001];
queue <int> coada;
bool vizitat[1001];
int tata[1001];

/// Functia de parcurgere pentru algoritmul de la flux

inline bool bfs()
{
    while (coada.empty() == false)
        coada.pop();

    for (int i=0; i<=2*n+1; i++)
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

        if (nod == 2*n + 1) return true;

        for (int i=1; i<= 2*n + 1; i++)
            if (vizitat[i] == false && mat[nod][i] > 0)
            {
                coada.push(i);
                tata[i] = nod;
                vizitat[i] = true;
            }
    }

    return false;
}

/// Functia pentru flux

inline int flux()
{
    while (bfs())
    {
        for (int i=n+1; i<2*n+1; i++)
        {
            if (mat[i][2*n + 1] > 0 && vizitat[i] == true)
            {
                int frunza = i;

                vector <int> drum;
                drum.push_back(2*n + 1);
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

/// Trebuie sa ne construim un graf (matricea grafului) pentru a putea
/// rula algoritmul de flux.

/// Pentru noduri:
/// --> adaugam un nod sursa si un nod destinatie
/// --> dublam nodurile

/// Pentru muchii:
/// --> adaugam muchii de la sursa la fiecare nod cu capacitati = gradul out
/// --> adaugam muchii de la fiecare nod la celelalte noduri cu capacitatea = 1
///     (nu ducem muchie de la un nod la el insusi)
/// --> adaugan muchii de la fiecare nod la destinatie cu capacitati = gradul in

void citire()
{
    citeste >> n;
    for (int i=1; i<=n; i++)
    {
        citeste >> x >> y;
        out[i] = x;
        in[i] = y;

        /// Voi considera nodul sursa = 0 si voi adauga muchiile de la
        /// sursa la fiecare nod (out).

        mat[0][i] = out[i];

        /// Pentru a dubla nodurile voi adauga in continuare noduri:
        /// (n+i) = dublura lui i

        /// Asadar, vom avea 2*n noduri la final. Voi considera nodul sursa = 2*n + 1
        /// si voi adauga muchiile de la noduri la destinatie (in)

        mat[n+i][2*n+1] = in[i];

        /// Adaug muchiile intre noduri cu capacitatea 1:

        for (int nod=1; nod<=n; nod++)
            if (nod != i)
                mat[i][n+nod] = 1;
    }
}

void raspuns ()
{
    /// Fluxul maxim = numarul de muchii adaugate (de aceea am pus
    /// capacitatea 1 pe muchie)

    scrie << maxflow << endl;

    /// Muchiile sunt cele care nu mai au capacitate.

    for (int i=1; i<=n; i++)
        for (int j=1; j<=n; j++)
            if (mat[i][n+j] == 0 && i != j)
                scrie << i << " " << j << endl;
}

int main()
{
    citire();
    flux();
    raspuns();
    return 0;
}
