#include <iostream>
#include <fstream>
#include <set>
#include <utility>

using namespace std;

ifstream citeste("zeap.in");
ofstream scrie("zeap.out");

set<int> zeap;
string operatie;
int element;
set<pair<int, pair<int, int>>> nr;

void inserare ()
{
    citeste >> element;
    if (zeap.find(element) == zeap.end())
    {
        zeap.insert(element);
        auto e = zeap.find(element);
        if (e != zeap.begin())
        {
            auto st = e;
            st --;
            nr.insert(make_pair(element - *st, make_pair(*st, element)));
        }
        auto dr = e;
        dr ++;
        if (dr != zeap.end())
            nr.insert(make_pair(*dr - element, make_pair(element, *dr)));
        }
}

void stergere ()
{
    citeste >> element;
    auto e = zeap.find(element);
    auto dr = e;
    auto st = e;
    if(e == zeap.end())
        scrie << "-1\n";
    else
    {
        if (e != zeap.begin() && ++e != zeap.end())
        {
            dr ++;
            st --;
            nr.insert(make_pair(*dr - *st, make_pair(*st, *dr)));
            auto eu = make_pair(element - *st, make_pair(*st, element));
            auto ed = make_pair(*dr - element, make_pair(element, *dr));
            nr.erase(eu);
            nr.erase(ed);
        }
        else if (e != zeap.begin() && e == zeap.end())
        {
            auto eu = make_pair(element - *st, make_pair(*st, element));
            nr.erase(eu);
        }
        else if (e == zeap.begin() && e != zeap.end())
        {
            auto ed = make_pair(*dr - element, make_pair(element, *dr));
            nr.erase(ed);
        }
    }
    zeap.erase(element);
}

void cauta ()
{
    citeste >> element;
    auto ok = zeap.find(element);
    if(ok == zeap.end())
        scrie << "0\n";
    else scrie << "1\n";
}

void maxim ()
{
    if (zeap.size() < 2)
        scrie << "-1\n";
    else
    {
        auto sfarsit = zeap.end();
        auto inceput = zeap.begin();
        sfarsit --;
        scrie << *sfarsit - *inceput << '\n';
    }
}

void minim ()
{
    if (zeap.size() < 2)
        scrie << "-1\n";
    else
    {
        auto inceput = nr.begin();
        auto m = *inceput;
        scrie << m.first << '\n';
    }
}

void citire ()
{
    while (citeste >> operatie)
    {
        if (operatie[0] == 'I')
            inserare ();
        else if (operatie[0] == 'S')
            stergere ();
        else if (operatie[1] =='A')
            maxim();
        else if (operatie[1] == 'I')
            minim();
        else if (operatie[0] == 'C')
            cauta();
    }
}

int main()
{
    citire ();
    return 0;
}
