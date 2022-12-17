#include <iostream>
#include <unordered_map>
#include <fstream>

using namespace std;

ifstream citeste("pariuri.in");
ofstream scrie("pariuri.out");

unordered_map <int, int> dict;
int n, m, t, b;

int main()
{
    citeste >> n;
    for (int i=0; i<n; i++)
    {
        citeste >> m;
        for (int im = 0; im<m; im++)
        {
            citeste >> t >> b;
            dict[t] += b;
        }
    }
    scrie << dict.size() << '\n';
    for(auto i = dict.cbegin(); i != dict.cend(); ++i)
    {
        scrie << i->first << " " << i->second << " ";
    }
    return 0;
}
