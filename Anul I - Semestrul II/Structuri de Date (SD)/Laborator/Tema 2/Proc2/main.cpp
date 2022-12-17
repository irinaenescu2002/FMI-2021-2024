#include <iostream>
#include <fstream>
#include <queue>
#include <utility>
#include <vector>

using namespace std;

ifstream citeste("proc2.in");
ofstream scrie("proc2.out");

int n, m, start, durata;
priority_queue <long long> procesoare;
priority_queue <pair<long long, long long>> taskuri;
vector <long long> ordine_procesoare;


void initializare ()
{
    citeste >> n >> m;
    for (int i=1; i<=n; i++)
        procesoare.push(-i);
}

void atribuire ()
{
    for (int i=0; i<m; i++)
    {
        citeste >> start >> durata;
        while (taskuri.empty() == false && -taskuri.top().first <= start)
        {
            int procesor_eliberat = taskuri.top().second;
            taskuri.pop();
            procesoare.push(procesor_eliberat);
        }
        taskuri.push(make_pair(-(start+durata), procesoare.top()));
        ordine_procesoare.push_back(procesoare.top());
        procesoare.pop();
    }
}

void afisare ()
{
    for (int i=0; i<ordine_procesoare.size(); i++)
        scrie << -ordine_procesoare[i] << '\n';
}

int main()
{
    initializare();
    atribuire();
    afisare();
    return 0;
}
