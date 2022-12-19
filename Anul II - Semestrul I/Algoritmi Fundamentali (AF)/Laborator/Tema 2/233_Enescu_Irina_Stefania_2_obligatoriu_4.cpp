#include <iostream>
#include <vector>
#include <queue>
#include <math.h>

using namespace std;

class Solution {
public:
    double maxProbability(int n, vector<vector<int>>& edges, vector<double>& succProb, int start, int end) {

	/// Complexitate: O(n+mlogn)        

	/// Folosesc o coada cu prioritate implementata invers pentru a obtine in top
        /// distanta cea mai mica, nu cea mai mare (asa cum era implicit).

        vector <vector <pair<int, double>>> lista_adiacenta(n);
        priority_queue <pair<double, int>, vector <pair<double, int>>, greater <pair<double, int>>> coada;
        vector <double> probabilitati;
        pair<double, int> pereche_extrasa;
        double probabilitate_extrasa, probabilitate_extrasa_vecin;
        int nod_extras, nod_extras_vecin;
        pair<int, double> vecin;

        /// Salvam graful cu ajutorul listei de adiacenta de forma:
        /// nod : [(vecin, probabilitate)]
        /// Tinem cont sa calculam probabilitatea cu ajutorul logaritmilor
        /// pentru a genera raspunsul corect.
        /// De asemenea, introducem probabilitatile cu - pentru a putea
        /// aplica Dijkstra si a gasi de fapt drumul cu cost minim.

        for (int i=0; i<edges.size(); i++)
        {
            int a = edges[i][0];
            int b = edges[i][1];
            double p = succProb[i];
            double minusLogP = -(log(p));
            lista_adiacenta[a].push_back({b, minusLogP});
            lista_adiacenta[b].push_back({a, minusLogP});
        }

         /// Setez probabilitatile initiale ca fiind infinit pentru a le putea minimiza ulterior.

        probabilitati.assign(n, 1e9);

        /// Pornim de la nodul de start cu probabilitatea curenta 0.

        coada.push({0, start});

        /// Cat timp mai avem vecini si probabilitati de prelucrat si analizat:

         while (coada.empty() == false)
         {
             /// Extragem perechea cu probabilitatea cea mai mica.

             pereche_extrasa = coada.top();
             probabilitate_extrasa = pereche_extrasa.first;
             nod_extras = pereche_extrasa.second;
             coada.pop();
             probabilitati[nod_extras] = probabilitate_extrasa;

             /// Daca am ajuns la nodul final, ne oprim si returnam probabilitatea gasita.

             if (nod_extras == end)
                 return exp(-probabilitati[nod_extras]);

             /// Pentru fiecare vecin al nodului din pereche:

             for (int i=0; i<lista_adiacenta[nod_extras].size(); i++)
             {
                 vecin = lista_adiacenta[nod_extras][i];
                 nod_extras_vecin = vecin.first;
                 probabilitate_extrasa_vecin = vecin.second;

            /// Daca am gasit o probabilitate mai mica, actualizam probabilitatea
            /// si adaugam perechea obtinuta in coada pentru a o prelucra ulterior.

            if (probabilitati[nod_extras_vecin] > probabilitati[nod_extras] + probabilitate_extrasa_vecin)
                 {
                     probabilitati[nod_extras_vecin] = probabilitati[nod_extras] + probabilitate_extrasa_vecin;
                     coada.push({probabilitati[nod_extras_vecin], nod_extras_vecin});
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
