#include <iostream>
#include <string>

using namespace std;

int n, v[11];
string actiuni;

void citire ()
{
    cin >> n;
    cin >> actiuni;
    for(int i=0; i<=9; i++)
        v[i] = 0;
}

void cazare ()
{
    int st, dr, camera;
    for(int i=0; i<actiuni.length(); i++)
    {
        if (actiuni[i] == 'L')
        {
            st = 0;
            while (v[st]!=0)
                st ++;
            v[st] = 1;
        }
        else if (actiuni[i] == 'R')
        {
            dr = 9;
            while (v[dr]!=0)
                dr --;
            v[dr] = 1;
        }
        else
        {
            camera = actiuni[i] - '0';
            v[camera] = 0;
        }
    }
}

void afisare()
{
    for (int i=0; i<=9; i++)
        cout << v[i];
}

int main()
{
    citire();
    cazare();
    afisare();
    return 0;
}
