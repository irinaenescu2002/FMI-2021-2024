#include <iostream>
#include <fstream>

using namespace std;

ifstream citeste("heapuri.in");
ofstream scrie("heapuri.out");

int numar_operatii, operatie, valoare;
int valori[100001];
int heap[100001];
int pozitii[100001];
int h, v;

/// valori ---> valorile elementelor citite
/// heap -----> pozitia valorii din vectorul valori
/// pozitii --> pozitia valorii din vectorul heap

int parinte (int i)
{
    return i/2;
}

int fiustang (int i)
{
    return i*2;
}

int fiudrept (int i)
{
    return i*2 + 1;
}

void interschimbare (int a, int b)
{
    int auxh = heap[a];
    heap[a] = heap[b];
    heap[b] = auxh;

    int auxp = pozitii[heap[a]];
    pozitii[heap[a]] = pozitii[heap[b]];
    pozitii[heap[b]] = auxp;
}

void urca (int i)
{
    int fiu = i;
    int tata = parinte(i);
    if (fiu != 0 && valori[heap[fiu]] < valori[heap[tata]])
    {
        interschimbare(fiu, tata);
        urca(tata);
    }
}

void coboara (int i)
{
    int tata = i;
    int fiu_stang = fiustang(i);
    int fiu_drept = fiudrept(i);
    int minim = tata;
    if (fiu_stang <= h && valori[heap[fiu_stang]] < valori[heap[tata]])
        minim = fiu_stang;
    if (fiu_drept <= h && valori[heap[fiu_drept]] < valori[heap[minim]])
        minim = fiu_drept;
    if (minim != tata)
    {
        interschimbare(tata, minim);
        coboara(minim);
    }
}

void adaugare (int valoare)
{
    v++;
    valori[v] = valoare;
    h++;
    heap[h] = v;
    pozitii[v] = h;
    urca(h);
}

void stergere (int i)
{
    int element = i;
    if (element == h)
        h --;
    else
    {
        interschimbare(element, h);
        h--;
        coboara(element);
        urca(element);
    }
}

int minim ()
{
    return valori[heap[1]];
}

void citire ()
{
    citeste >> numar_operatii;
    for(int i=1; i<=numar_operatii; i++)
    {
        citeste >> operatie;
        if (operatie == 1)
        {
            citeste >> valoare;
            adaugare(valoare);
        }
        else if (operatie == 2)
        {
            citeste >> valoare;
            stergere(pozitii[valoare]);
        }
        else if (operatie == 3)
            scrie << minim() << '\n';
    }
}

int main()
{
    citire();
    return 0;
}
