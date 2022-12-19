#include <iostream>
#include <vector>
#include<queue>

using namespace std;

class Solution {
public:
    int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {

        /// Complexitate: O(n + (nr_zboruri*k*log(nr_zboruri*k)))

        /// Coada de prioritati este de forma:
        /// {costul de la nodul de start, nodul curent, numarul de orase vizitate}

        vector <vector <pair<int, int>>> lista_adiacenta(n);
        priority_queue <vector <int>, vector <vector <int>>, greater<vector <int>>> coada;
        vector <int> opriri;
        int raspuns = -1;

        /// Salvam in lista de adiacenta zborurile si costurile corespunzatoare.

        for (int i=0; i<flights.size(); i++)
        {
            auto zbor = flights[i];
            auto plecare = zbor[0];
            auto destinatie = zbor[1];
            auto distanta = zbor[2];
            lista_adiacenta[plecare].push_back({destinatie, distanta});
        }

        /// Pentru fiecare oras facem un vector de costuri minime pentru fiecare
        /// pas, mai exact pentru cate opriri putem avea pana la k.

        opriri.assign(n, 1e9);

        /// Incepem cu costul 0, pornind de la punctul de plecare, cu 0 orase
        /// vizitate pana acum.

        coada.push({0, src, 0});

        while (coada.empty() == false)
        {
            auto pereche_extrasa = coada.top();
            int cost = pereche_extrasa[0];
            int plecare = pereche_extrasa[1];
            int numar_orase = pereche_extrasa[2];
            coada.pop();

            /// Daca am depasit numarul de orase de vizitat, continuam
            /// pentru a returna -1.

            if (numar_orase > k + 1)
                continue;

            /// Daca am gasit o cale cu cost mai mic si mai putine opriri
            /// continuam.

            if (numar_orase > opriri[plecare])
                continue;

            opriri[plecare] = numar_orase;

            /// Daca am ajuns la destinatie, salvam costul sa il returnam.

            if (plecare == dst)
            {
                raspuns = cost;
                break;
            }

            /// Pentru fiecare viitoare destinatie in care putem merge, introducem
            /// in coada o noua posibilitate de parcurgere, adaugand costul
            /// vecinului la cel curent si incrementand numarul de orase.

            for (auto zbor_vecin : lista_adiacenta[plecare])
            {
                auto destinatie_vecin = zbor_vecin.first;
                auto cost_vecin = zbor_vecin.second;

                coada.push({cost + cost_vecin, destinatie_vecin, numar_orase + 1});
            }
        }

        return raspuns;
    }
};

int main()
{
    cout << "Hello world!" << endl;
    return 0;
}
