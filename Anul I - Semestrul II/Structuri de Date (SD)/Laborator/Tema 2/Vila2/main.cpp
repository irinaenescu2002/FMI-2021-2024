#include <iostream>
#include <fstream>
#include <deque>
#include <vector>
#include <algorithm>

using namespace std;

ifstream citeste("vila2.in");
ofstream scrie("vila2.out");

int n, k, vila;
vector <int> varste;
deque <int> varste_minime;
deque <int> varste_maxime;
vector <int> diferente;


void citire ()
{
    citeste >> n >> k;
    varste.push_back(-1111);
    while (citeste >> vila)
        varste.push_back(vila);
}

void prelucrare ()
{
    for (int vila=1; vila<=n; vila++)
    {
        while (varste_minime.size() != 0 && varste[vila] <= varste[varste_minime.back()])
            varste_minime.pop_back();

        while (varste_maxime.size() != 0 && varste[vila] >= varste[varste_maxime.back()])
            varste_maxime.pop_back();

        varste_maxime.push_back(vila);
        varste_minime.push_back(vila);

        if (vila >= k)
            diferente.push_back(varste[varste_maxime.front()] - (varste[varste_minime.front()]));

        if(varste_minime.front() <= vila - k)
            varste_minime.pop_front();

        if(varste_maxime.front() <= vila - k)
            varste_maxime.pop_front();
    }
}

int main()
{
    citire();
    prelucrare();
    scrie << *max_element(diferente.begin(), diferente.end());
    return 0;
}
