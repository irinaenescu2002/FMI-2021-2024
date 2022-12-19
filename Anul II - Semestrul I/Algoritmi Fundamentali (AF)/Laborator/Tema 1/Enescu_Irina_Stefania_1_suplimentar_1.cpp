/// Critical Connections in Network

#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector <vector<int>> lista, raspuns;
    vector<int> aux;
    int vizitat[100001], timp_minim[100001], nod_minim[100001], contor;

    void citire_liste(int n, vector<vector<int>>& connections)
    {
        /// Am salvat vecinii fiecarui nod cu ajutorul listelor de adiacenta.

        lista.assign(n + 1, vector<int>());
        for (auto connection : connections)
        {
            lista[connection[0]].push_back(connection[1]);
            lista[connection[1]].push_back(connection[0]);
        }

        /// Am pregatit un vector auxiliar pentru a retine fiecare muchie critica.

        aux.push_back(0);
        aux.push_back(0);
    }

        /// Am remodelat algoritmul lui Tarjan de gasire a componentelor
        /// tare conexe dintr-un graf orientat, ignorand sensul muchiilor
        /// si bazandu-ma pe evitarea distrugerii unor drumuri de intoarcere.
        /// Complexitate: O(n+m)

    void dfs(int nod_curent, int nod_precedent, int n, vector<vector<int>>& connections)
    {
        /// Odata ce am ajuns la nodul_curent:
        /// -- il marcam ca fiind vizitat
        /// -- ii stabilim momentul descoperirii (in time value)
        /// -- ii stabilim nodul vizitat precedent, mai exact nodul descoperit
        ///    dinaintea lui (low link value)

        vizitat[nod_curent] = 1;
        contor ++;
        timp_minim[nod_curent] = contor;
        nod_minim[nod_curent] = contor;

        /// Dupa aceea incepem parcurgerea propriu zisa pentru fiecare vecin al sau, utilizand dfs.
        /// Daca nodul vecin nu a fost vizitat, mergem cu parcurgerea mai departe. Dupa ce ne
        /// intoarcem recursiv in parcurgere, ii minimizam low link value in raport
        /// cu al vecinului sau.
        /// Daca nodul vecin a fost deja vizitat si este diferit de cel vizitat anterior,
        /// ii minimizam low link value. Aceasta este minimul dintre valoarea actuala a sa
        /// si valoarea in time a nodului vecin.
        /// In cazul in care low link value este mai mare decat in time value, inseamna ca avem
        /// o punte care leaga nodurile deoarece acest lucru nu trebuia sa se intample in cazul
        /// in care exista o cale de intoarcere catre toate nodurile grafului.

        for(auto nod_vecin : lista[nod_curent])
        {
            if (!vizitat[nod_vecin])
            {
                dfs(nod_vecin, nod_curent, n, connections);
                nod_minim[nod_curent] = min(nod_minim[nod_vecin], nod_minim[nod_curent]);
            }
            else if (nod_vecin != nod_precedent)
            {
                nod_minim[nod_curent] = min(nod_minim[nod_curent], timp_minim[nod_vecin]);
            }
            if (nod_minim[nod_vecin] > timp_minim[nod_curent])
            {
                aux[0] = nod_curent;
                aux[1] = nod_vecin;
                raspuns.push_back(aux);
            }
        }
    }

    vector<vector<int>> criticalConnections(int n, vector<vector<int>>& connections) {

        citire_liste(n, connections);
        dfs(0, -1, n, connections);
        return raspuns;
    }
};

int main()
{
    cout << "Hello world!" << endl;
    return 0;
}
