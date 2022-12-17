#include <iostream>
#include<vector>

using namespace std;

int n;
int st[100001];

void citire ()
{
    cin >> n;
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
    cout << endl;
}

void bktr (int niv)
{
    for (int i=1; i<=n; i++)
    {
        st[niv] = i;
        if (valid(niv)==1)
            if (niv == n)
            {
                afis(niv);
            }
            else bktr(niv+1);
    }
}

int main()
{
    citire();
    bktr(1);
    return 0;
}
