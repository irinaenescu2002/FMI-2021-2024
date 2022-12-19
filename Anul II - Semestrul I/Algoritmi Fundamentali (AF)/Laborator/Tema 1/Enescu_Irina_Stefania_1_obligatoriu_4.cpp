/// CTC
/// ------------------- VARIANTA 1 (TARJAN) -> O(n+m) -------------------

#include <iostream>
#include <fstream>
#include <vector>
#include <stack>

using namespace std;

ifstream citeste("ctc.in");
ofstream scrie("ctc.out");

vector <vector<int>> lista, ctc;
stack <int> stiva;
int n, m, vizitat[100001], noduri_valide[100001], timp_minim[100001], nod_minim[100001], numar_ctc, top_stiva, contor = 1;

/// Am salvat vecinii fiecarui nod cu ajutorul listelor de adiacenta.

void citire_liste()
{
    citeste >> n >> m;
    lista.assign(n + 1, vector<int>());
    for (int i=1; i<=m; i++)
    {
        int x, y;
        citeste >> x >> y;
        lista[x].push_back(y);
    }
}

/// Pentru a gasi componentele tare conexe am folosit algoritmul lui Tarjan.
/// Acesta se bazeaza pe parcurgerea grafului in adancime.

void dfs(int nod_curent)
{
    /// Odata ce am ajuns la nodul_curent:
    /// -- il marcam ca fiind vizitat
    /// -- ii stabilim momentul descoperirii (in time)
    /// -- ii stabilim nodul vizitat precedent, mai exact nodul descoperit dinaintea lui (low link value)
    /// -- il adaugam pe o stiva pentru a putea salva componenta conexa curenta
    /// -- il adaugam ca fiind parte din componenta conexa curenta (ca fiind nod valid)

    vizitat[nod_curent] = 1;
    contor ++;
    timp_minim[nod_curent] = contor;
    nod_minim[nod_curent] = contor;
    noduri_valide[nod_curent] = 1;
    stiva.push(nod_curent);

    /// Dupa aceea incepem parcurgerea propriu zisa pentru fiecare vecin al sau.
    /// Daca nodul vecin a fost deja vizitat si face parte din nodurile valide,
    /// incercam sa ii minimizam low link value. Aceasta este minimul dintre valoarea actuala a sa
    /// si valoarea in time a nodului vecin.
    /// Daca nodul vecin nu a fost vizitat, mergem cu parcurgerea mai departe. Dupa ce ne
    /// intoarcem recursiv in parcurgere, verificam daca nodul se regaseste inca in lista
    /// de noduri valide. In caz afirmativ, ii minimizam si lui low link value in raport
    /// cu al vecinului sau.

    for(auto nod_vecin : lista[nod_curent])
    {
        if(vizitat[nod_vecin] && noduri_valide[nod_vecin])
            nod_minim[nod_curent] = min(nod_minim[nod_curent], timp_minim[nod_vecin]);
        else if (!vizitat[nod_vecin])
        {
            dfs(nod_vecin);
            if(noduri_valide[nod_vecin])
                nod_minim[nod_curent] = min(nod_minim[nod_vecin], nod_minim[nod_curent]);
        }
    }

    /// In cazul in care low link value si in time value sunt aceleasi, inseamna
    /// ca avem de a face cu o noua componenta tare conexa. O salvam in vectorul
    /// componentelor tare conexe si eliminam nodurile valide pentru a pregati terenul
    /// pentru urmatoarea componenta tare conexa.

    if(timp_minim[nod_curent] == nod_minim[nod_curent])
    {
        numar_ctc ++;
        while(true)
        {
            top_stiva = stiva.top();
            stiva.pop();
            noduri_valide[top_stiva] = 0;
            ctc[numar_ctc].push_back(top_stiva);
            if(top_stiva == nod_curent) break;
        }
    }
}

int main()
{
    citire_liste();
    ctc.assign(n + 1, vector<int>());
    ios::sync_with_stdio(false);

    /// Pentru fiecare nod, daca nu a fost vizitat, pornim parcurgerea
    /// in scopul gasirii unei componente tare conexe.

    for(int i=1; i<=n; i++)
        if(!vizitat[i])
            dfs(i);

    /// La final, componentele tare conexe vor fi salvate dupa index
    /// in vectorul ctc.

    scrie << numar_ctc;

    for (auto componenta : ctc)
    {
        for (auto nod : componenta)
            scrie << nod << " ";
        scrie << '\n';
    }
}


/*

------------------- VARIANTA 2 (+-) -> O(n+m) ~ O(n^2) -------------------

#include <iostream>
#include <fstream>

using namespace std;

ifstream citeste("ctc.in");
ofstream scrie("ctc.out");


/// Vom folosi algoritmul Plus Minus:
/// -- determinam toate nodurile in care se poate ajunge din x, marcandu-le cu plus (noduri_plus)
/// -- determinam toate nodurile din care se poate ajunge din x, marcandu-le cu minus (noduri_minus)
/// Nodurile marcate cu plus si cu minus, impreuna cu nodul x vor reprezenta o componenta conexa.
/// ALgoritmul are complexitate O(n+m), iar in cazul nefavorabil O(n^2).

/// Vectorul ctc va retine numarul de ordine al componentei conexe din care face parte fiecare nod:
/// ----> ctc[i] = numarul de ordine al componentei din care face parte i

int n, m, mat[100002][100002], noduri_plus[100002], noduri_minus[100002], ctc[100002], nr_ctc;


/// Construim matricea de adiacenta a grafului (notata mat), marcand muchiile existente cu 1.

void citire()
{
    citeste >> n >> m;
    for (int i=1; i<=m; i++)
    {
        int x, y;
        citeste >> x >> y;
        mat[x][y] = 1;
    }
}


/// Folosim parcurgerea in adancime pentru a marca toate nodurile in care se poate ajunge din x.
/// Marcam nodul curent, apoi cautam muchie pentru a trece mai departe doar in cazul in care nu am
/// trecut deja prin nodul respectiv.

void dfs_plus(int nod_curent)
{
    noduri_plus[nod_curent] = 1;
    for (int i=1; i<=n; i++)
        if (mat[nod_curent][i] == 1 && noduri_plus[i] == 0)
            dfs_plus(i);
}


/// Folosim parcurgerea in adancime pentru a marca toate nodurile din care se poate ajunge din x.
/// Marcam nodul curent, apoi cautam muchie pentru a trece mai departe doar in cazul in care nu am
/// trecut deja prin nodul respectiv.

void dfs_minus(int nod_curent)
{
    noduri_minus[nod_curent] = 1;
    for (int i=1; i<=n; i++)
        if (mat[i][nod_curent] == 1 && noduri_minus[i] == 0)
            dfs_minus(i);
}


int main()
{
    /// Pentru fiecare nod incercam sa gasim componenta conexa.
    /// Daca nodul i nu apartine deja unei componenta tare-conexe, reinitializam vectorii
    /// de marcare pentru a gasi componenta sa conexa.
    /// Aplicam parcurgerile pentru a marca cu plus si minus nodurile, adaugand la numarare
    /// o noua componenta conexa.
    /// Daca un nod a fost vizitat in ambele parcurgeri, nodul respectiv face parte din componenta
    /// tare-conexa cu numarul curent.

    citire();
    for (int i=1; i<=n; i++)
        if (ctc[i] == 0)
        {
            for (int j=1; j<=n; j++)
                noduri_minus[j] = noduri_plus[j] = 0;
            nr_ctc ++;
            dfs_plus(i);
            dfs_minus(i);
             for (int j=1; j<=n; j++)
                if (noduri_minus[j] == 1 && noduri_plus[j] == 1)
                    ctc[j] = nr_ctc;
        }
    scrie << nr_ctc << '\n';
    for (int i=1; i<=nr_ctc; i++)
    {
        for (int j=1; j<=n; j++)
            if (ctc[j] == i)
                scrie << j << " ";
        scrie << '\n';
    }
    return 0;
}

*/
