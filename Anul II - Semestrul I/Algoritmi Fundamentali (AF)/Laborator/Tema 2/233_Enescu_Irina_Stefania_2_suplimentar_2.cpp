#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:

    /// Complexitate: O(q*logn)

    /// Cautare_radacina si reuniune se bazeaza pe functiile implementate in problema DISJOINT.

    int parinte[100001];
    int inaltime[100001];

    /// Functie de cautare a radacinii.

    int cautare_radacina(int nod)
    {
        if (parinte[nod] != nod)
            parinte[nod] = cautare_radacina(parinte[nod]);
        return parinte[nod];
    }

    /// Functie de reuniune a doua noduri prin legarea radacinii.

    void reuniune (int x, int y)
    {
        auto radacinax = cautare_radacina(x);
        auto radacinay = cautare_radacina(y);
        if (radacinax == radacinay) return;
        if (inaltime[radacinax] < inaltime[radacinay])
            parinte[radacinax] = radacinay;
        else if (inaltime[radacinax] > inaltime[radacinay])
            parinte[radacinay] = radacinax;
        else
        {
            parinte[radacinay] = radacinax;
            inaltime[radacinax] ++;
        }
    }

    /// Functie de ordonare dupa distanta.

    static bool ordonare(vector<int> &x, vector<int> &y)
    {
        return x[2] < y[2];
    }

    vector<bool> distanceLimitedPathsExist(int n, vector<vector<int>>& edgeList, vector<vector<int>>& queries)
{
        vector <bool> answer(queries.size(), false);

        /// Plasam fiecare nod intr-o multime.

        for(int i=0; i<n; i++)
            parinte[i] = i;

        /// Retinem indexul fiecarui test pentru a aranja corect raspunsurile corect raspunsurile in vector,
        /// intrucat in urma sortarii acestea nu vor mai fi de la 0 la queries.size().

        for(int i=0; i<queries.size(); i++)
            queries[i].push_back(i);

        /// Pentru a evita TLE si a nu face prelucrari inutile, sortam vectorii.

        sort(edgeList.begin(), edgeList.end(), ordonare);
        sort(queries.begin(), queries.end(), ordonare);

        int i = 0;

        /// Pentru fiecare test din lista facem multimi de noduri cu conditia sa
        /// existe un drum de la nodul de start la nodul final care este compus
        /// din muchii cu distanta mai mica decat limita impusa.

        for (auto test : queries)
        {
            auto limita = test[2];
            while (i < edgeList.size() && edgeList[i][2] < limita)
                {
                    auto x = edgeList[i][0];
                    auto y = edgeList[i][1];
                    if (cautare_radacina(x) != cautare_radacina(y))
                        reuniune(x, y);
                    i ++;
                }

                auto start = test[0];
                auto end = test[1];
                auto index = test[3];

        /// In cazul in care nodurile fac parte din aceeasi multime, exista un drum.

                if (cautare_radacina(start) == cautare_radacina(end))
                    answer[index] = true;
        }

        return answer;

    }
};

int main()
{
    cout << "Hello world!" << endl;
    return 0;
}
