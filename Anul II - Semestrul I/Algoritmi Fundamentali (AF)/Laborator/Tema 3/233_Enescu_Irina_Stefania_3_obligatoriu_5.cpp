#include <iostream>
#include <set>
#include <queue>

using namespace std;

/// Complexitate: O(n^2 * 2^n)

class Solution {
public:
    int shortestPathLength(vector<vector<int>>& graph) {

        /// Pentru a retine toate informatiile necesare la fiecare pas, in coada
        /// vom adauga: {nod curent, {distanta curenta, noduri vizitate}}

        queue <pair <int, pair <int, int>>> coada;

        /// Pentru a nu ajunge intr-o bucla infinita de vizitare de tipul
        /// (nod1 - nod2 - nod1 - nod2 - ...) salvam nodurile vizitate intr-o multime
        /// de forma {(nod curent, noduri_vizitate)}

        set <pair <int, int>> vizitate;

        /// Ne vom folosi de operatiile cu biti pentru a marca nodurile vizitate:
        ///     Noduri:  4 3 2 1 0
        ///     Vizitat: 0 0 0 1 1
        /// Secventa de mai sus semnifica faptul ca nodurile 1 si 0 au fost vizitate,
        /// iar nodurile 2, 3, 4 nu. Asadar, ne vom opri la 111111 pe care il obtinem:
        ///     (1 << n ) = 2^n * 1
        ///     (1 << n) - 1 = 1111...111 (1 de n ori)

        auto end = (1 << graph.size()) - 1;

        /// Trebuie sa facem BFS din toate nodurile pentru a ne asigura ca verificam toate posibilitatile.
        /// Plecam din fiecare nod cu distanta curenta 0 si cu nodul curent vizitat.

        for (int nod=0; nod<graph.size(); nod++)
            coada.push(make_pair(nod, make_pair(0, 1<<nod)));

        for (int nod=0; nod<graph.size(); nod++)
            vizitate.insert(make_pair(nod, 1<<nod));

        while (coada.empty() == false)
        {
            auto x = coada.front();
            coada.pop();

            auto nod_curent = x.first;
            auto distanta_curenta = x.second.first;
            auto vizitat_curent = x.second.second;

            for (auto vecin : graph[nod_curent])
            {
                /// Pentru a calcula numarul ce semnifica nodurile vizitate vom folosi OR:
                ///     00001 (nodul 0 vizitat)
                ///     00010 (nodul 1 e vecinul lui 0 si il vizitam)
                ///  or -----
                ///     00011 (nodul 1 si nodul 0 sunt vizitate)

                auto actualizare_vizitat = (vizitat_curent | 1 << vecin);

                /// Daca am vizitat toate nodurile returnam distanta + muchia noua parcursa,
                /// altfel continuam parcurgerea pana vizitam toate nodurile.

                if (actualizare_vizitat == end) return distanta_curenta + 1;
                else if (vizitate.count(make_pair(vecin, actualizare_vizitat)) != 0) continue;
                else
                {
                    coada.push(make_pair(vecin, make_pair(distanta_curenta + 1, actualizare_vizitat)));
                    vizitate.insert(make_pair(vecin, actualizare_vizitat));
                }
            }
        }

        return 0;
    }
};

int main()
{
    cout << "Hello world!" << endl;
    return 0;
}
