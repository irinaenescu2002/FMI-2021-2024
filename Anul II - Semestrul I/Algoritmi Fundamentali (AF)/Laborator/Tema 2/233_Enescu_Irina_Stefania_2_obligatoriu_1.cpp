/// RETEA2

/// N centrale electrice si M blocuri
/// Un bloc are curent daca:
/// -- e conectat la o centrala electrica
/// -- e conectat la un bloc care primeste curent
/// Avem coordonatele fiecarei cladiri si stim ca costul = distanta dintre cladiri
/// Care e costul minim pentru a transmite curent la toate blocurile?

/// Complexitate: O(m*logn)

#include <iostream>
#include <vector>
#include <fstream>
#include <math.h>
#include <iomanip>
#include <queue>

#define infinit 1e9

using namespace std;

ifstream citeste("retea2.in");
ofstream scrie("retea2.out");

/// Folosesc o coada cu prioritate implementata invers pentru a obtine in top
/// distanta cea mai mica, nu cea mai mare (asa cum era implicit).

long long n, m, x, y, xbloc, ybloc, xbloc_nou, ybloc_nou, index_bloc, nr_blocuri_verificate, xindex_bloc, yindex_bloc, xcentrala, ycentrala;
vector <pair <long long, long long>> cladiri, blocuri, centrale;
vector <double> distanta;
double dist, raspuns, distanta_extrasa;
vector <bool> blocuri_verificate;
priority_queue <pair <double, long long>, vector <pair <double, long long>>, greater <pair <double, long long>>> coada;
pair <double, long long> pereche_extrasa;

void citire()
{
    citeste >> n >> m;

    /// Salvam coordonatele centralelor atat in vectorul de centrale,
    /// cat si in vectorul de cladiri.

    for (int i=0; i<n; i++)
    {
        citeste >> x >> y;
        centrale.push_back({x,y});
        cladiri.push_back({x,y});
    }

    /// Salvam coordonatele blocurilor atat in vectorul de blocuri,
    /// cat si in vectorul de cladiri.

    for (int i=0; i<m; i++)
    {
        citeste >> x >> y;
        blocuri.push_back({x,y});
        cladiri.push_back({x, y});
    }
}

/// Calculam distanta de la fiecare cladire la o centrala.

void distanta_minima_cladire_centrala()
{
    /// Initializam distanta minima ca fiind infinit.

    distanta.assign(n+m, infinit);

    /// Pentru fiecare bloc, pentru fiecare centrala, calculam distanta dintre ele
    /// si o alegem pe cea mai mica, adaugand-o intr-o coada cu prioritati de distante
    /// (necesara pentru optimizare).

    for (long unsigned int i=centrale.size(); i<centrale.size() + blocuri.size(); i++)
    {
        xbloc = cladiri[i].first;
        ybloc = cladiri[i].second;

        for (long unsigned int j=0; j<centrale.size(); j++)
        {
            xcentrala = centrale[j].first;
            ycentrala = centrale[j].second;
            dist = sqrt(1LL*(xbloc - xcentrala)*(xbloc - xcentrala) + 1LL*(ybloc - ycentrala)*(ybloc - ycentrala));
            if (dist < distanta[i])
                distanta[i] = dist;
        }

        coada.push({distanta[i], i});
    }
}

/// Incercam sa optimizam conexiunile pentru a avea un APM. Verificam astfel daca
/// este mai avantajos sa legam un bloc de alt bloc conectat la o centrala, si nu
/// direct de o centrala.

void optimizare_blocuri()
{
    /// Initial, toate blocurile sunt neverificate.

    blocuri_verificate.assign(n+m, false);

    /// Cat timp mai avem blocuri de verificat:

    while (nr_blocuri_verificate < m)
    {
        /// Extragem din coada distanta curenta si indexul blocului.

        pereche_extrasa = coada.top();
        coada.pop();
        distanta_extrasa = pereche_extrasa.first;
        index_bloc = pereche_extrasa.second;

        /// Daca blocul extras nu a fost verificat:

        if (blocuri_verificate[index_bloc] == false)
        {
            /// Incercam sa il optimizam, marcandu-l ca verificat si adaugand
            /// la raspuns distanta corespunzatoare (aceasta este minima datorita
            /// cozii de prioritati).

            blocuri_verificate[index_bloc] = true;
            nr_blocuri_verificate ++;
            raspuns += pereche_extrasa.first;

            /// Retinem coordonatele blocului curent.

            xindex_bloc = cladiri[index_bloc].first;
            yindex_bloc = cladiri[index_bloc].second;

            /// Verificam daca este mai convenabil sa il legam de un alt bloc,
            /// in loc sa il legam de o centrala. In caz afirmativ, actualizam
            /// distanta si urcam in coada blocul de care l-am legat pentru a-l
            /// verifica ulterior si pe acesta.

            for (int i=n; i<m+n; i++)
            {
                xbloc_nou = cladiri[i].first;
                ybloc_nou = cladiri[i].second;

                dist = sqrt(1LL*(xindex_bloc - xbloc_nou)*(xindex_bloc - xbloc_nou) + 1LL*(yindex_bloc - ybloc_nou)*(yindex_bloc - ybloc_nou));
                if (blocuri_verificate[i] == false && dist < distanta[i])
                {
                    distanta[i] = dist;
                    coada.push({dist, i});
                }
            }
        }
    }
}

int main()
{
    citire();
    distanta_minima_cladire_centrala();
    optimizare_blocuri();
    scrie << fixed << setprecision(6) << raspuns;
    return 0;
}
