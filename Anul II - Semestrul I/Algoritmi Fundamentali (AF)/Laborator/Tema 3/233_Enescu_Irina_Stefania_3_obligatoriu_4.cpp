#include <iostream>
#include <unordered_map>
#include <algorithm>
#include <vector>

using namespace std;

/// Complexitate: O(n+m)

/// Problema se rezuma la a gasi un ciclu eulerian sau un lant eulerian.
/// --> ciclu eulerian: out[nod] = in[nod] pentru fiecare nod
/// --> lant eulerian: out[nod] = in[nod] pentru fiecare nod,
///     mai putin doua noduri:
///     --> start: out[start] - in[start] = 1
///     --> final: in[final] - out[final] = 1

class Solution {
public:

    unordered_map <int, vector<int>> lista_adiacenta;
    unordered_map <int, int> in;
    unordered_map <int, int> out;
    vector <vector <int>> raspuns;

    /// Functie de parcurgere a grafului muchie cu muchie (in sens invers).
    /// Nu mai marcam nodul ca fiind vizitat pentru a ne putea reintoarce in el.
    /// Extragem muchia parcursa pentru a nu o parcurge si a doua
    /// oara si o adaugam la raspuns.

    void dfs (int nod_curent)
    {
        auto &vecini = lista_adiacenta[nod_curent];
        while (!vecini.empty())
        {
            auto nod_vecin = vecini.back();
            vecini.pop_back();
            dfs(nod_vecin);
            raspuns.push_back({nod_curent, nod_vecin});
        }
    }

    vector<vector<int>> validArrangement(vector<vector<int>>& pairs) {

        /// Formez lista de adiacenta a grafului si calculez gradele
        /// de intrare si de iesire ale fiecarui nod.

        for (int i=0; i<pairs.size(); i++)
        {
            lista_adiacenta[pairs[i][0]].push_back(pairs[i][1]);
            in[pairs[i][1]] += 1;
            out[pairs[i][0]] += 1;
        }

        int nod_start = -1;

        /// Caut nodul de start din care sa pornesc, asigurandu-ma astfel ca
        /// acopar si cazul unui ciclu, dar si al unui lant

        for(auto muchii : lista_adiacenta)
            if (out[muchii.first] - in[muchii.first] == 1)
                nod_start = muchii.first;

        /// Daca nu am gasit unul, avem ciclu si plec cu nodul din prima muchie.

        if (nod_start == -1) nod_start = pairs[0][0];

        /// Facem parcurgerea in adancime a grafului.

        dfs(nod_start);

        /// Inversam ordinea muchiilor.

        reverse(raspuns.begin(), raspuns.end());

        return raspuns;
    }
};

int main()
{
    cout << "Hello world!" << endl;
    return 0;
}
