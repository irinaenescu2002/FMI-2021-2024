/// Complexitate: O(n+m)

#include <iostream>
#include <fstream>
#include <algorithm>
#include <vector>
#include <unordered_map>

using namespace std;

ifstream citeste("johnie.in");
ofstream scrie("johnie.out");

int n, m, x, y, nr;
unordered_map <int, vector <pair <int, int>>> lista_adiacenta(50001);
unordered_map <int, int> grad;
unordered_map <int, vector <int>> raspuns;
vector <bool> muchii_vizitate(1000001);

void citire()
{
    citeste >> n >> m;

    /// Formez lista de adiacenta a grafului si calculez gradele fiecarui nod.
    /// Identific muchia cu un numar de ordine unic (acest lucru ne va ajuta
    /// ulterior deoarece Johnie nu vrea sa treaca de doua ori pe aceeasi muchie).

    for (int uid=0; uid<m; uid++)
    {
        citeste >> x >> y;
        lista_adiacenta[x].push_back({y, uid});
        lista_adiacenta[y].push_back({x, uid});
        grad[x] += 1;
        grad[y] += 1;
    }
}

/// Problema se rezuma la a cauta lanturi euleriene.

/// Capetele unui lant eulerian sunt noduri cu grad impar, asadar legam
/// de acestea o noua sursa. Stiind sursa, stim de unde sa pornim si putem
/// gasi lanturile mai usor.

/// Numarul de ordine unic poate fi format cu nod + m.

void adaugare_sursa()
{
    for (int nod=1; nod<=n; nod++)
        if (grad[nod]%2)
        {
            lista_adiacenta[nod].push_back({0, nod + m});
            lista_adiacenta[0].push_back({nod, nod + m});
        }
}

/// Functie de parcurgere a grafului in adancime muchie cu muchie.
/// Nu mai marcam nodul ca fiind vizitat pentru a ne putea reintoarce in el.

void dfs (int nod_curent)
{
    auto &vecini = lista_adiacenta[nod_curent];

    while (!vecini.empty())
    {
        auto pereche_vecina = vecini.back();
        auto nod_vecin = pereche_vecina.first;
        auto muchie_vecina = pereche_vecina.second;

        vecini.pop_back();

        /// Continuam pe muchia respectiva doar daca nu a fost vizitata.

        if (muchii_vizitate[muchie_vecina] == false)
        {
            muchii_vizitate[muchie_vecina] = true;
            dfs(nod_vecin);
        }
    }

    /// Daca am ajuns la sursa avem de a face cu un lant nou,
    /// altfel adaugam nodul la drumul curent.

    if (nod_curent == 0) nr++;
    else raspuns[nr].push_back(nod_curent);
}

void afisare_raspuns()
{
    scrie << raspuns.size() << endl;
    for (auto etapa : raspuns)
    {
        scrie << etapa.second.size() << " ";
        for (auto nod : etapa.second)
            scrie << nod << " ";
        scrie << '\n';
    }
}

int main()
{
    citire();
    adaugare_sursa();
    dfs(0);
    afisare_raspuns();
    return 0;
}
