#include <iostream>
#include <fstream>
#include <unordered_set>
#include <deque>

using namespace std;

ifstream citeste("muzica.in");
ofstream scrie("muzica.out");

long long nrvasile, nrdj, a, b, c, d, e, melodie, melodienoua;
deque <long long> muzicadj;
unordered_set <long long> muzicavasile(10000);
long long numar;

int main()
{
    citeste >> nrvasile >> nrdj;
    citeste >> a >> b >> c >> d >> e;
    for (long long i=0; i<nrvasile; i++)
    {
        citeste >> melodie;
        muzicavasile.insert(melodie);
    }

    muzicadj.push_back(a);
    if (muzicavasile.find(a) != muzicavasile.end())
    {
        numar ++;
        muzicavasile.erase(a);
    }
    muzicadj.push_back(b);
    if (muzicavasile.find(b) != muzicavasile.end())
    {
        numar ++;
        muzicavasile.erase(b);
    }

    while (nrdj > 2)
    {
        melodienoua = (c*muzicadj[1] + d*muzicadj[0]) % e;
        if (muzicavasile.find(melodienoua) != muzicavasile.end())
        {
            numar ++;
            muzicavasile.erase(melodienoua);
        }
        muzicadj.push_back(melodienoua);
        muzicadj.pop_front();
        nrdj --;
    }

    scrie << numar;

    return 0;
}
