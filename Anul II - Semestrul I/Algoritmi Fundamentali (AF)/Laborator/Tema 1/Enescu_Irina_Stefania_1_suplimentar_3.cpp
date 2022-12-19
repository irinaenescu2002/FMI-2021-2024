/// --------------------- VARIANTA 1 (BFS) ---------------------

#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

ifstream citeste("graf.in");
ofstream scrie("graf.out");

int n, m, x, y, a, b, numar_lanturi, nod_extras;
vector <vector<int>> lista(75001);
vector <int> cnt(14001);
vector <int> dx(75001), dy(75001);
queue <int> coada;
vector <bool> vizitat;
vector <int> noduri_comune;

/// Salvez graful cu ajuorul listelor de adiacenta.

void citire()
{
    citeste >> n >> m >> x >> y;
    for (int i=1; i<=m; i++)
    {
        citeste >> a >> b;
        lista[a].push_back(b);
        lista[b].push_back(a);
    }
}

/// Parcurg graful in latime (BFS) pornind atat de la nodul x, cat si de la
/// nodul y astfel incat sa retin distantele de la fiecare nod la nodul x, respectiv la nodul y.
/// La finalul parcurgerii vom putea afla distanta minima de la x la y (notata dy[x] sau dx[y]), acest
/// lucru simbolizand lungimea minima pe care trebuie sa o aiba lantul.

void bfsx (int nod_initial)
{
    for (int i=0; i<=n; i++)
        vizitat.push_back(false);

    coada.push(nod_initial);
    vizitat[nod_initial] = true;
    dx[nod_initial] = 1;

    while (!coada.empty())
    {
        nod_extras = coada.front();
        coada.pop();

        for (auto nod_vecin : lista[nod_extras])
        {
            if(!vizitat[nod_vecin])
            {
                coada.push(nod_vecin);
                vizitat[nod_vecin] = true;
                dx[nod_vecin] = dx[nod_extras] + 1;
            }
        }
    }
}

void bfsy (int nod_initial)
{
    for (int i=0; i<=n; i++)
        vizitat[i] = false;

    coada.push(nod_initial);
    vizitat[nod_initial] = true;
    dy[nod_initial] = 1;

    while (!coada.empty())
    {
        nod_extras = coada.front();
        coada.pop();

        for (auto nod_vecin : lista[nod_extras])
        {
            if(!vizitat[nod_vecin])
            {
                coada.push(nod_vecin);
                vizitat[nod_vecin] = true;
                dy[nod_vecin] = dy[nod_extras] + 1;
            }
        }
    }
}

/// In functia selectare extrag nodurile care sunt comune tuturor lanturilor de lungime minima.
/// Am utilizat formula d(x, nod) + d(nod, y) = d(x, y) pentru a gasi nodurile care fac parte
/// dintr-un lant optim. Contorizez cate noduri valide am pe fiecare nivel al parcurgerii in latime.
/// In cazul in care nodurile nu fac parte dintr-un lant optim, le anulez marcand distanta cu 0.
/// Daca pe un nivel am un singur nod, acest lucru inseamna ca este nod de legatura intre nivele si se
/// gaseste in toate lanturile optime, asa ca il salvam pentru a-l afisa ulterior sortat.

void selectare ()
{
    for(int i=1; i<=n; i++)
        if (dx[i] + dy[i] == dx[y] + 1)
            cnt[dx[i]] ++;
        else dx[i] = 0;

    for(int i=1; i<=n; i++)
        if(cnt[dx[i]] == 1)
        {
            numar_lanturi ++;
            noduri_comune.push_back(i);
        }

    scrie << numar_lanturi << '\n';
    sort(noduri_comune.begin(), noduri_comune.end());
    for (auto nod : noduri_comune)
        scrie << nod << " ";

}

int main ()
{
    citire();
    bfsx(x);
    bfsy(y);
    selectare();
}

/*
---------------- VARIANTA 2 (BKTR) ----------------------

#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

ifstream citeste("graf.in");
ofstream scrie("graf.out");

int n, m, x, y, a, b, st[7505], mat[7505][7505], contor_aparitii[7505], numar_lanturi_minime;
vector<vector<int>> lanturi;
vector<int> noduri_comune;
long unsigned int lungime_minima;

void citire()
{
    citeste >> n >> m >> x >> y;
    for(int i=1; i<=m; i++)
    {
        citeste >> a >> b;
        mat[a][b] = mat[b][a] = 1;
    }
    st[1] = x;
}

int validare (int niv)
{
    for (int i=1; i<niv; i++)
        if (st[niv] == st[i])
            return 0;
    if (mat[st[niv]][st[niv-1]] == 0)
        return 0;
    return 1;
}

void afis ()
{
    scrie << noduri_comune.size() << '\n';
    sort(noduri_comune.begin(), noduri_comune.end());
    for (auto nod: noduri_comune)
        scrie << nod << " ";
}

void salvare (int niv)
{
    vector<int> aux;
    for (int i=1; i<=niv; i++)
        aux.push_back(st[i]);
    lanturi.push_back(aux);
}

void bktr (int niv)
{
    for (int vf=1; vf<=n; vf++)
    {
        st[niv] = vf;
        if (validare(niv))
        {
            if (st[niv] == y)
                salvare(niv);
            else bktr(niv+1);
        }
    }
}

void selectare()
{
    for (auto lant: lanturi)
        if (lant.size() > lungime_minima)
            lungime_minima = lant.size();
    for (auto lant: lanturi)
        if (lant.size() == lungime_minima)
        {
            numar_lanturi_minime ++;
            for (auto nod: lant)
                contor_aparitii[nod] ++;
        }
    for (int i=1; i<=n; i++)
        if (contor_aparitii[i] == numar_lanturi_minime)
                noduri_comune.push_back(i);
}

int main()
{
    citire();
    bktr(2);
    selectare();
    afis();
    return 0;
}
*/
