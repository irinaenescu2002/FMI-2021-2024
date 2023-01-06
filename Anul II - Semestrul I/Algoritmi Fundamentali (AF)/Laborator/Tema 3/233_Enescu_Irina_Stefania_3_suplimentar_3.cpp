/// Complexitate: O(n*m*m)

#include <iostream>
#include <queue>
#include <algorithm>
#include <vector>

#pragma GCC optimize "O3"

using namespace std;

int numere[20002], n, mat[20002][20002], maxflow, tata[20002];
queue <int> coada;
bool vizitat[20002];
vector <vector <int>> lista_adiacenta(20002);
vector <int> numere_raspuns;

void citire(){

    cin >> n;

    /// Tratam fiecare numar ca un nod in graf, recunoscandu-l dupa index.

    for (int i=1; i<=n; i++){

        cin >> numere[i];

        /// Pentru a construi graful bipartit pe care sa rulam flux, punem numerele
        /// impare in stanga si numerele pare in dreapta. Adaugam un nod nou sursa (0)
        /// si un nod nou destinatie (n+1). Pe toate muchiile punem capacitatea 1.

        /// De ce impartim astfel?
        /// -> par + par = par, numar divizibil cu 2 (deci nu e prim)
        /// -> impar + impar = par, numar diviziibil cu 2 (deci nu e prim)
        /// Asadar trebuie sa verificam doar sumele par + impar.

        /// In plus, salvam si lista de adiacenta a grafului deoarece nu o sa avem
        /// muchii intre toate nodurile din stanga si din dreapta.

        if (numere[i] % 2 == 1){
            mat[0][i] = 1;
            lista_adiacenta[0].push_back(i);
            lista_adiacenta[i].push_back(0);
        }

        if (numere[i] % 2 == 0){
            mat[i][n+1] = 1;
            lista_adiacenta[n+1].push_back(i);
            lista_adiacenta[i].push_back(n+1);
        }
    }
}

/// Functie ce verifica daca un numar este prim sau nu.

bool prim (int n) {

    if (n == 1 || n == 0)
        return false;

    for (int i=2; i<=n/2; i++)
        if (n % i == 0)
            return false;

    return true;
}

/// Vom adauga muchii intre cele doua partitii doar acolo unde avem
/// perechi de numere cu suma prima.

void adaugare_muchii(){

    for (int i=1; i<n; i++)
        for (int j=i+1; j<=n; j++){
            if (prim(numere[i] + numere[j])){
                if (numere[i] % 2 == 1)
                    mat[i][j] = 1;
                else
                    mat[j][i] = 1;
                lista_adiacenta[i].push_back(j);
                lista_adiacenta[j].push_back(i);
            }
        }
}

/// Functie de parcurgere pentru algoritmul flux.

bool bfs(){

    while (coada.empty() == false)
        coada.pop();

    for (int i=0; i<=n+1; i++){
        tata[i] = -1;
        vizitat[i] = false;
    }

    coada.push(0);
    vizitat[0] = true;

    while (coada.empty() == false){

        auto nod = coada.front();
        coada.pop();

        if (nod == n+1) return true;

        /// Modificare: nu mai mergem pe toate nodurile, ci doar pe cele vecine

        for (unsigned long int i=0; i<lista_adiacenta[nod].size(); i++){

            auto vecin = lista_adiacenta[nod][i];

            if (vizitat[vecin] == false && mat[nod][vecin] > 0){
                coada.push(vecin);
                tata[vecin] = nod;
                vizitat[vecin] = true;
            }
        }
    }

    return false;
}

/// Algoritmul pentru flux

inline int flux() {

    while (bfs()) {

        for (int i=1; i<=n; i++){

            if (mat[i][n+1] > 0 && vizitat[i] == true){

                int frunza = i;

                vector <int> drum;
                drum.push_back(n+1);
                drum.push_back(frunza);

                int nod = tata[frunza];

                if (nod == 0)
                    drum.push_back(nod);
                else{
                    while (nod != 0){
                        drum.push_back(nod);
                        nod = tata[nod];
                    }
                    drum.push_back(0);
                }

                reverse(drum.begin(), drum.end());

                int capacitate_minima = 110001;

                for(long unsigned int i=0; i<drum.size()-1; i++)
                    capacitate_minima = min(capacitate_minima, mat[drum[i]][drum[i+1]]);

                maxflow += capacitate_minima;

                for(long unsigned int i=0; i<drum.size()-1; i++){
                    mat[drum[i]][drum[i+1]] -= capacitate_minima;
                    mat[drum[i+1]][drum[i]] += capacitate_minima;
                }
            }
        }
    }

    return maxflow;
}

void raspuns(){

    /// Conform articolului de la indicatii:

    /// Dupa ce am rulat flux vom avea doua tipuri de noduri: vizitate si nevizitate.
    /// Trebuie sa alegem:
    /// --> nodurile vizitate din partea dreapta (pare)
    /// --> nodurile nevizitate din partea stanga (impare)

    int nr = 0;

    for(int i=1; i<=n; i++){
        if ((numere[i] % 2 == 1 && vizitat[i] == false) || (numere[i] % 2 == 0 && vizitat[i] == true))
            numere_raspuns.push_back(numere[i]), nr++;
    }

    cout << nr << '\n';
    for (int i = 0; i < nr; i++)
        cout << numere_raspuns[i] << " ";
}


int main() {
    citire();
    adaugare_muchii();
    flux();
    raspuns();
}

