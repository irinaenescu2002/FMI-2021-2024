#include <iostream>
#include <fstream>
#include <stack>
#include <string>
#include <vector>
#include <deque>

using namespace std;

ifstream citeste ("alibaba.in");
ofstream scrie ("alibaba.out");

int n, k;
stack <int> st;
vector <int> numere;
deque <int> raspuns;
string numar_scris;

void citire ()
{
    citeste >> n >> k;
    citeste >> numar_scris;

    for(int i=0; i<n; i++)
        numere.push_back(numar_scris[i] - '0');
}

void prelucrare_stiva ()
{
    for (int i=0; i<n; i++)
    {
        while (st.empty() == 0 && st.top() < numere[i] && k > 0)
        {
            st.pop();
            --k;
        }
        st.push(numere[i]);
    }
}

void eliminare ()
{
    while (k != 0)
    {
        st.pop();
        --k;
    }
}

void formare_raspuns ()
{
    while (st.empty() == 0)
    {
        raspuns.push_front(st.top());
        st.pop();
    }

    for(int i=0; i<raspuns.size(); i++)
        scrie << raspuns[i];
}

int main()
{
    citire();
    prelucrare_stiva();
    eliminare();
    formare_raspuns();
    return 0;
}
