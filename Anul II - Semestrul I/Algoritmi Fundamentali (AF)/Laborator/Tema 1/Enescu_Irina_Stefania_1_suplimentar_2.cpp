#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

ifstream citeste("padure.in");
ofstream scrie("padure.out");

int n, m, linie_start, coloana_start, linie_castel, coloana_castel, sfarsit_pas, pas_actual, pas, cost;
int padure[1001][1001];
int vizitat[1001][1001];
vector <int> schimbare_linie, schimbare_coloana;
int dx[5], dy[5];

void initializare_distante ()
{
    /// Salvam doi vectori de directie pentru coordonate x si y.
    /// dx = [-1, 0, 1, 0];
    /// dy = [0, 1, 0, -1];

    /// Acestia ne vor ajuta sa ne deplasam in matrice la nord,
    /// sud, est si vest pe principiul:
    /// -- d[-1][0] = vest
    /// -- d[0][1] = nord
    /// -- d[1][0] = est
    /// -- d[0][-1] = sud

    dx[1] = -1;
    dy[1] = 0;
    dx[2] = 0;
    dy[2] = 1;
    dx[3] = 1;
    dy[3] = 0;
    dx[4] = 0;
    dy[4] = -1;
}

void citire ()
{
    citeste >> n >> m >> linie_start >> coloana_start >> linie_castel >> coloana_castel;
    for (int i=1; i<=n; i++)
        for(int j=1; j<=m; j++)
            citeste >> padure[i][j];
}

void plimbare (int linie, int coloana, int tip_copac)
{
    /// Oprim plimbarea recursiva prin matrice in cazul in care:
    ///    - iesim din matrice (primele patru conditii)
    ///    - am vizitat deja zona
    ///    - am ajuns la castel

    if (linie < 1) return;
    if (linie > n) return;
    if (coloana < 1) return;
    if (coloana > m) return;
    if (vizitat[linie][coloana] == 1) return;
    if (vizitat[linie_castel][coloana_castel] == 1) return;

    /// In cazul in care am schimbat tipul de copaci, retinem
    /// coordonatele zonei in care s-a intamplat acest lucru
    /// si oprim plimbarea de la pasul actual.

    if (padure[linie][coloana] != tip_copac)
    {
        schimbare_linie.push_back(linie);
        schimbare_coloana.push_back(coloana);
        sfarsit_pas ++;
        return;
    }

    /// Marcam zona respectiva ca fiind vizitata si incercam
    /// sa ii vizitam recursiv vecinii la nord, sud, vest si est.
    /// Adaugam astfel in coada de schimbari toate zonele in
    /// care am schimbat tipul de copaci si bordam padurea cu
    /// copacul actual cu padurile cu tipuri de copaci diferite.

    vizitat[linie][coloana] = 1;
    for(int i=1; i<=4; i++)
        plimbare(linie + dx[i], coloana + dy[i], tip_copac);

}

int bfs_padure()
{
    /// Daca nu am ajuns la castel din prima plimbare (mai exact daca nu am putut
    /// ajunge la castel fara a schima copacii), trebuie sa parcurgem si zonele
    /// cu copaci diferiti de zona de plecare.
    /// Cat timp nu am ajuns inca la castel, parcurgem progresiv si zonele de
    /// padure vecine pornind de la fiecare coordonata de schimbare.
    /// De fiecare data cand ajungem la un nou nivel de parcurgere adaugam
    /// un diamant la cost.

    while (vizitat[linie_castel][coloana_castel] != 1)
    {
        pas_actual = sfarsit_pas;
        while (pas < pas_actual)
        {
            plimbare(schimbare_linie[pas], schimbare_coloana[pas], padure[schimbare_linie[pas]][schimbare_coloana[pas]]);
            pas ++;
        }
        cost ++;
    }

    return cost;
}

int main()
{
    citire();
    initializare_distante();
    plimbare(linie_start, coloana_start, padure[linie_start][coloana_start]);
    if (vizitat[linie_castel][coloana_castel] == 1)
        scrie << 0;
    else scrie << bfs_padure();
    return 0;
}
