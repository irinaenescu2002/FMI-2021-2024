#include <iostream>
#include <fstream>
#include <cstring>
#include <string>
#include <stack>

using namespace std;

ifstream citeste("queue.in");
ofstream scrie("queue.out");

int n;
string operatie;

stack <int> stiva1;
stack <int> stiva2;

int wr, poz;

int formare_numar(int poz)
{
    wr = 0;
    while (operatie[poz] != ')')
    {
        wr = wr*10 + (operatie[poz] - '0');
        poz ++;
    }
    return wr;
}

void operatie_push(string operatie)
{
    wr = formare_numar(poz = 10);
    scrie << "read(" << wr <<") ";
    stiva1.push(wr);
    scrie << "push(1," << wr << ")";
}

void operatie_pop(string operatie)
{
    if (stiva2.size() != 0)
    {
        scrie << "pop(2) " << "write(" << stiva2.top() << ")";
        stiva2.pop();
    }
    else
    {
        while (stiva1.size() > 1)
        {
            scrie << "pop(1) ";
            stiva2.push(stiva1.top());
            stiva1.pop();
            scrie << "push(2," << stiva2.top() << ") ";
        }
        scrie << "pop(1) " << "write(" << stiva1.top() << ") ";
        stiva1.pop();
    }
}

void citire_operatie ()
{
    citeste >> n;
    for (int i=1; i<=n; i++)
    {
        citeste >> operatie;
        scrie << i << ": ";
        if (operatie[1] == 'u')
            operatie_push(operatie);
        else operatie_pop(operatie);
        scrie << "\n";
    }
}

int main()
{
    citire_operatie();
    return 0;
}
