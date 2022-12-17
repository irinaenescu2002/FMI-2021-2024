#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

ifstream citeste("timbre.in");
ofstream scrie("timbre.out");

vector <int> interval;
vector <int> cost;
int nr_pag, nr_intrv, lg_max;
int mrg_sup_intrv, cost_intrv;
int cost_minim;
int poz_cumparat;
int suma;

void citire()
{
    citeste >> nr_pag >> nr_intrv >> lg_max;
    for (int i=0; i<nr_intrv; i++)
    {
        citeste >> mrg_sup_intrv >> cost_intrv;
        cost.push_back(cost_intrv);
        interval.push_back(mrg_sup_intrv);
    }
}

void selectare ()
{
    while (nr_pag > 0)
    {
        cost_minim = 10001;
        for(int i=0; i<nr_intrv; i++)
            if (interval[i] >= nr_pag && cost[i] < cost_minim)
            {
                poz_cumparat = i;
                cost_minim = cost[i];
            }
        suma += cost_minim;
        nr_pag -= lg_max;
        cost[poz_cumparat] = -1;
        interval[poz_cumparat] = -1;
    }
}

int main()
{
    citire();
    selectare();
    scrie << suma;
    return 0;
}
