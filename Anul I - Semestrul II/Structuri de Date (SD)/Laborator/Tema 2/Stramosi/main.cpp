#include <iostream>
#include <fstream>
#pragma GCC optimize ("O3")

using namespace std;

ifstream citeste("stramosi.in");
ofstream scrie("stramosi.out");

int n, m, pers, nr, s[250001], str, raspuns, mat[2501][2501];

int main()
{
    ios::sync_with_stdio(0);
    citeste >> n >> m;
    for(int i=1; i<=n; i++)
    {
        citeste >> s[i];
        mat[i][1] = s[i];
    }
    for (int i=1; i<=n; i++)
        for (int j=2; j<=n; j++)
            mat[i][j] = mat[mat[1][j-1]][1];


    for(int i=1; i<=m; i++)
    {
        citeste >> pers >> nr;
        cout << mat[pers][nr] << '\n';
    }
    return 0;
}
