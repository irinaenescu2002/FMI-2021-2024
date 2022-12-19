/// CATUN

/// Complexitate O((n+m)logn)

/// Cautarea drumului minim de la fiecare asezare la o fortareata:
/// -- 0 -> asezarea i este este o fortareata sau este un catun
///         de la care nu se poate ajunge la nici o fortareata
/// -- numar fortareata -> asezarea i se leaga de fortareata respectiva

#include <iostream>
#include <fstream>
#include <vector>
#include <queue>

#define infinit 1e9

using namespace std;

ifstream citeste("catun.in");
ofstream scrie("catun.out");

/// Folosesc o coada cu prioritate implementata invers pentru a obtine in top
/// distanta cea mai mica, nu cea mai mare (asa cum era implicit).

int n, m, k, x, y, z;
int fortarete[36001], distanta[36001], solutie[36001];
vector <vector <pair <int, int>>> lista_adiacenta;
priority_queue <pair <int, int>, vector <pair <int, int>>, greater <pair <int, int>>> coada;
pair <int, int> pereche_extrasa, vecin;
int nod_extras, distanta_extrasa;
int nod_extras_vecin, distanta_extrasa_vecin;
int aux;


void dijsktra (int nod_start)
{
    /// Setez distanta fortaretei egala cu 0, aceasta fiind punctul de plecare.
    /// Urc in coada de prioritati perechea (distanta, nodul de pornire).

    distanta[nod_start] = 0;
    coada.push({0, nod_start});

    /// Cat timp mai avem vecini si distante de prelucrat si analizat:

    while(coada.empty() == false)
    {
        /// Extragem perechea cu distanta cea mai mica.

        pereche_extrasa = coada.top();
        coada.pop();

        distanta_extrasa = pereche_extrasa.first;
        nod_extras = pereche_extrasa.second;

        /// Pentru fiecare vecin al nodului din pereche:

        for (int j=0; j<lista_adiacenta[nod_extras].size(); j++)
        {
            vecin = lista_adiacenta[nod_extras][j];
            nod_extras_vecin = vecin.first;
            distanta_extrasa_vecin = vecin.second;

            /// Daca am gasit un drum nou mai scurt, actualizam distanta, setam
            /// solutia ca fiind fortareata de unde am plecat si adaugam perechea obtinuta
            /// in coada pentru a o prelucra ulterior.

            if (distanta[nod_extras_vecin] > distanta[nod_extras] + distanta_extrasa_vecin)
            {
                distanta[nod_extras_vecin] = distanta[nod_extras] + distanta_extrasa_vecin;
                solutie[nod_extras_vecin] = nod_start;
                coada.push({distanta[nod_extras_vecin], nod_extras_vecin});
            }
        }
    }

}

void citire ()
{
    citeste >> n >> m >> k;

    /// Setez distantele initiale ca fiind infinit pentru a le putea minimiza ulterior.

    for (int i=1; i<=n; i++)
        distanta[i] = infinit;

    /// Setez solutia fiecarui catun 0 pentru a acoperi catunele in care nu se poate ajunge.

    for (int i=1; i<=n; i++)
        solutie[i] = 0;

    for (int i=0; i<k; i++)
        citeste >> fortarete[i];

    lista_adiacenta.resize(n+1);

    /// Sortez fortaretele crescator pentru a acoperi cazul in care fortaretele se afla la
    /// aceeasi distanta. Astfel, algoritmul o va alege pe cea cu indexul cel mai mic.

    for (int i=0; i<k-1; i++)
        for (int j=i+1; j<k; j++)
            if (fortarete[i] >= fortarete[j])
            {
                aux = fortarete[i];
                fortarete[i] = fortarete[j];
                fortarete[j] = aux;
            }

    /// Salvez graful cu ajutorul listelor de adiacenta;
    /// --> nod : [(nod_vecin, distanta_pana_la_nodul_vecin)]

    for (int i=0; i<m; i++)
    {
        citeste >> x >> y >> z;
        lista_adiacenta[x].push_back(make_pair(y, z));
        lista_adiacenta[y].push_back(make_pair(x, z));
    }

}

void aplicare_dijkstra()
{
    /// Aplic Dijkstra pe fiecare fortareata pentru a actualiza solutia cu valoarea
    /// cea mai mica posibila.

    for(int i=0; i<k; i++)
        dijsktra(fortarete[i]);

    /// Ma asigur ca fortaretele au solutia egala cu 0, evitand astfel riscul unui raspuns
    /// gresit datorat modificarilor din Dijkstra.

    for(int i=0; i<k; i++)
        solutie[fortarete[i]] = 0;
}

void afisare()
{
    for(int i=1; i<=n; i++)
        scrie << solutie[i] << " ";
}

int main()
{
    citire();
    aplicare_dijkstra();
    afisare();
    return 0;
}
