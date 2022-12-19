#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minCostConnectPoints(vector<vector<int>>& points) {

        /// Complexitate: O(n^2logn)

        /// Folosesc o coada cu prioritate implementata invers pentru a obtine in top
        /// distanta cea mai mica, nu cea mai mare (asa cum era implicit).

        priority_queue <pair <int, int>, vector <pair <int, int>>, greater <pair <int, int>>> coada;
        vector <bool> vizitat;

        /// Initializez distanta minima cu 0 (nu am unit nimic pana acum)
        /// si contorul cu 0 pentru a verifica daca am unit toate punctele
        /// (nu am unit nici un punct pana acm).

        int distanta_minima = 0;
        int contor_noduri = 0;

        /// Marchez toate punctele ca fiind nevizitate.

        vizitat.assign(points.size(), false);

        /// Urc primul punct in coada cu ajutorul indexului sau.

        coada.push({0,0});

        /// Cat timp mai avem puncte de unit si elemente de verificat in coada:

        while (coada.empty() == false && contor_noduri < points.size())
        {
            /// Extragem punctul cu distanta curenta cea mai mica.

            auto pereche_extrasa = coada.top();
            auto distanta_extrasa = pereche_extrasa.first;
            auto index_punct_extras = pereche_extrasa.second;
            coada.pop();

            /// Chiar daca am vizitat deja punctul, nu il sarim pentru a nu omite o distanta
            /// ce va minimiza drumul.

            if(vizitat[index_punct_extras] == true)
                continue;

            /// Marcam punctul ca fiind vizitat, apoi crestem numarul de noduri.
            /// Adaugam distanta sa la raspuns.

            vizitat[index_punct_extras] = true;
            contor_noduri ++;
            distanta_minima += distanta_extrasa;

            /// Salvam coordonatele punctului curent.

            auto xpunct_extras = points[index_punct_extras][0];
            auto ypunct_extras = points[index_punct_extras][1];

            /// Pentru fiecare punct din lista calculam distanta dintre el si
            /// punctul curent. Adaugam distanta in coada pentru a putea extrage ulterior
            /// distanta cea mai mica si a continua.

            for (int index_punct=0; index_punct<points.size(); index_punct++)
            {
                if (vizitat[index_punct] == false)
                {
                     auto punct_nou_extras = points[index_punct];
                     auto xpunct_nou_extras = punct_nou_extras[0];
                     auto ypunct_nou_extras = punct_nou_extras[1];

                     int distanta = abs(xpunct_extras - xpunct_nou_extras) + abs(ypunct_extras - ypunct_nou_extras);
                     coada.push({distanta, index_punct});
                }
            }
        }

        return distanta_minima;

    }
};

int main()
{
    cout << "Hello world!" << endl;
    return 0;
}
