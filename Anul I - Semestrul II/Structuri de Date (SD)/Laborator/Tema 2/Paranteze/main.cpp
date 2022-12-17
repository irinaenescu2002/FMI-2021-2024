#include <bits/stdc++.h>
#include <iostream>
#include <string>
#include <fstream>
#include <vector>

using namespace std;

ifstream citeste("paranteze.in");
ofstream scrie("paranteze.out");

int n, lungime_maxima;
string sir;
vector <char> paranteze;
vector <int> pozitii;

void citire ()
{
    citeste >> n;
    citeste >> sir;
}

void parcurgere ()
{
    lungime_maxima = 0;
    for(int i=0; i<n; i++)
    {
        if(sir[i] == '(' || sir[i] == '{' || sir[i] == '[')
            {
                paranteze.push_back(sir[i]);
                pozitii.push_back(i);
            }
        else
        {
            if ((sir[i] == ')' && paranteze.back() == '(') == true
                    || (sir[i] == ']' && paranteze.back() == '[') == true
                    || (sir[i] == '}' && paranteze.back() == '{') == true)
            {
                paranteze.pop_back();
                pozitii.pop_back();
                if (pozitii.empty() == false)
                    lungime_maxima = max(lungime_maxima, i-pozitii.back());
                else
                    lungime_maxima = max(lungime_maxima, i+1);
            }
            else {
                paranteze.push_back(sir[i]);
                pozitii.push_back(i);
            }
        }
    }
}

int main()
{
    citire();
    parcurgere();
    scrie << lungime_maxima;
    return 0;
}
