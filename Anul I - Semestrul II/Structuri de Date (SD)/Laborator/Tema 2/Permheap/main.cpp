#include <iostream>
#include <fstream>

using namespace std;

ifstream citeste("permheap.in");
ofstream scrie("permheap.out");

int n, nr;
int st[1000001];

void citire ()
{
    citeste >> n;
    for(int i=1; i<=n; i++)
        st[i] = 0;
}

int valid (int niv)
{
    for (int i=1; i<=niv-1; i++)
        if (st[niv] == st[i])
            return 0;
    return 1;
}

void afis (int niv)
{
    for(int i=1; i<=niv; i++)
        cout << st[i] << " ";
    cout << '\n';
}

int verificareminim(int niv)
{
    for(int i=1; i<=niv; i++)
    {
        if (st[i] > st[2*i] && st[2*i] != 0)
            return 0;
        if (st[i] > st[2*i+1] && st[2*i+1] != 0)
            return 0;
    }
    return 1;
}

void bktr (int niv)
{
    for (int i=1; i<=n; i++)
    {
        st[niv] = i;
        if (valid(niv)==1)
            if (niv == n)
            {
                if (verificareminim(niv))
                    nr++;
            }
            else bktr(niv+1);
    }
}

int main()
{
    citire();
    bktr(1);
    scrie << nr;
    return 0;
}
