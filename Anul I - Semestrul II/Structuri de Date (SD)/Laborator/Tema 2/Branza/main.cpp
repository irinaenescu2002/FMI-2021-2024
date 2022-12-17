#include <iostream>
#include <fstream>
#include <deque>
#include <vector>

using namespace std;

ifstream citeste("branza.in");
ofstream scrie("branza.out");

int n, t, s;
long long cost_minim_necesar, cst, cnt, cost_pastrare;

vector <long long> cost;
vector <long long> cantitate;
deque <int> oferta_saptamanala;

void citire ()
{
    citeste >> n >> s >> t;
    cost.push_back(-1111);
    cantitate.push_back(-1111);
    for (int i=1; i<=n; i++)
    {
        citeste >> cst >> cnt;
        cost.push_back(cst);
        cantitate.push_back(cnt);
    }
}

void prelucrare ()
{
    for (int saptamana_curenta=1; saptamana_curenta<=n; saptamana_curenta++)
    {

        while (oferta_saptamanala.empty() == false && saptamana_curenta > oferta_saptamanala.front() + t)
            oferta_saptamanala.pop_front();

        while (oferta_saptamanala.empty() == false)
        {
            cost_pastrare = (saptamana_curenta - oferta_saptamanala.back()) * s;
            if (cost[oferta_saptamanala.back()] + cost_pastrare > cost[saptamana_curenta])
                oferta_saptamanala.pop_back();
            else break;
        }

        oferta_saptamanala.push_back(saptamana_curenta);

        cost_pastrare = (saptamana_curenta - oferta_saptamanala.front()) * s;
        cost_minim_necesar += cantitate[saptamana_curenta] * (cost[oferta_saptamanala.front()] + cost_pastrare);
    }
}

int main()
{
    citire();
    prelucrare();
    scrie << cost_minim_necesar;
    return 0;
}
