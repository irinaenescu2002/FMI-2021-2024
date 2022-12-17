#include <bits/stdc++.h>
#include <fstream>

using namespace std;

ifstream c("sereja.in");

string sir, sir_mic;
int m, a, b;

int lungimemaxima (string sir)
{
    stack<char> stiva;
    for(int i=0; i<sir.length(); i++)
        if(sir[i] == '(')
            stiva.push('(');
        else if (stiva.empty() == false)
            stiva.pop();
    return sir.length() - stiva.size() - 1;
}

void citire ()
{
    c >> sir;
    c >> m;
    for(int i=1; i<=m; i++)
    {
        c >> a >> b;
        sir_mic = sir.substr(a-1, b-a+1);
        cout << sir_mic << endl;
        cout << lungimemaxima(sir_mic) << endl;
    }

}
int main()
{
    citire();
    return 0;
}
