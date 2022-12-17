#include <iostream>
#include <vector>
#include <fstream>

using namespace std;

ifstream citeste("hashuri.in");
ofstream scrie("hashuri.out");

vector <int> listuta[19938];
int numar_operatii, operatie, parametru;


void adaugare(int parametru)
{
    bool gasit = false;
    int mod = parametru % 19937;
    for (long unsigned int i=0; i<listuta[mod].size(); i++)
        if (parametru == listuta[mod][i])
            gasit = true;
    if (gasit == false)
        listuta[mod].push_back(parametru);
}

void stergere (int parametru)
{
    int mod = parametru % 19937;
    for (long unsigned int i=0; i<listuta[mod].size(); i++)
        if (parametru == listuta[mod][i])
            listuta[mod].erase(listuta[mod].begin() + i);
}

void apartenenta(int parametru)
{
    bool gasit = false;
    int mod = parametru % 19937;
    for (long unsigned int i=0; i<listuta[mod].size(); i++)
        if (listuta[mod][i] == parametru)
            gasit = true;
    if (gasit)
        scrie << 1 << '\n';
    else scrie << 0 << '\n';
}

void citire ()
{
    citeste >> numar_operatii;
    for(int i=0; i<numar_operatii; i++)
    {
        citeste >> operatie >> parametru;
        if (operatie == 1)
            adaugare(parametru);
        else if (operatie == 2)
            stergere(parametru);
        else if (operatie == 3)
            apartenenta(parametru);
    }
}

int main()
{
    citire();
    return 0;
}
