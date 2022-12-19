/// https://csacademy.com/contest/archive/task/catch-the-thief/solution/

/// 1. No cycle
/// 2. All the nodes should be within distance 2 of a central path (the diameter).

#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

ifstream citeste("lesbulan.in");
ofstream scrie("lesbulan.out");

int t, n, m, x, y;
bool test_ciclu, test_structura_lant;
vector <vector <int>> lista_adiacenta;
vector <bool> vizitat, frunze;
vector <int> grade;

void dfs_verificare_ciclu (int nod_curent, int tata)
{
    vizitat[nod_curent] = true;
    for(auto vecin : lista_adiacenta[nod_curent])
    {
        /// In cazul in care am vizitat deja vecinul unui nod si tatal sau
        /// nu este nodul anterior vizitat, am gasit un ciclu.

        if (vizitat[vecin] == false)
            dfs_verificare_ciclu(vecin, nod_curent);
        else if (vizitat[vecin] == true && vecin != tata)
            test_ciclu = false;
    }
}

void eliminare_frunze()
{
    /// Daca gradul unui nod este 1, acest lucru inseamna ca nodul este frunza.

    for(int i=1; i<=n; i++)
        if (grade[i] == 1)
            frunze[i] = true;

    /// Daca nodul este frunza, il eliminam anulandu-i gradul.
    /// Eliminarea lui conduce la scaderea gradului vecinilor sai.

    for(int i=1; i<=n; i++)
        if(frunze[i] == true)
        {
            grade[i] -= 1;
            for(auto vecin: lista_adiacenta[i])
                grade[vecin] -= 1;
        }
}

void verificare_lant()
{
    /// Daca gradul fiecarui nod este mai mic decat 2, acest lucru
    /// inseamna ca graful are structura de lant.

    for(int i=1; i<=n; i++)
        if (grade[i] > 2)
            test_structura_lant = false;
}

void citire()
{
    citeste >> t;
    while (t)
    {
        citeste >> n >> m;

        /// Reactualizam listele de adiacenta, vectorul pentru marcarea vizitarii nodurilor si
        /// vectorul pentru grade pentru fiecare configuratie de buncare.

        lista_adiacenta.assign(n + 1, vector<int>());
        vizitat.assign(n + 1, false);
        grade.assign(n + 1, 0);

        /// Citim muchiile grafului si le salvam intr-o lista de adiacenta.

        for(int i=0; i<m; i++)
        {
            citeste >> x >> y;
            lista_adiacenta[y].push_back(x);
            lista_adiacenta[x].push_back(y);
        }

        /// Calculam gradul fiecarui nod.

        for(int i=1; i<=n; i++)
            grade[i] = lista_adiacenta[i].size();


        /// Presupunem ca configuratia curenta trece de primul test, testul existentei unui ciclu.
        /// Parcurgem graful in adancime pentru a gasi un eventual ciclu.

        test_ciclu = true;
        for(int i=1; i<=n; i++)
            if (vizitat[i] == false)
                dfs_verificare_ciclu(i, 0);

        /// Daca configuratia curenta nu a trecut de primul test, nu exista o strategie posibila.

        if(!test_ciclu)
            scrie << 0 << '\n';

        /// Daca configuratia curenta a trecut de primul test, trecem la urmatorul:
        /// structura unui lant cu frunze situate la distanta de maxim doua muchii.

        if (test_ciclu)
        {
            /// Reinitializam vectorul de cautare a frunzelor de doua ori si
            /// eliminam frunzele de doua ori.

            frunze.assign(n + 1, false);
            eliminare_frunze();
            frunze.assign(n + 1, false);
            eliminare_frunze();

            /// Presupunem ca configuratia trece si testul de structura.
            /// Verificam structura configuratiei.

            test_structura_lant = true;
            verificare_lant();

            /// In cazul in care nu il trece, nu exista o strategie posibila,
            /// altfel exista una si Lesbulan poate fi prins.

            if(!test_structura_lant)
                scrie << 0 << '\n';
            else scrie << 1 << '\n';
        }

        t -= 1;
    }
}

int main()
{
    citire();
    return 0;
}
