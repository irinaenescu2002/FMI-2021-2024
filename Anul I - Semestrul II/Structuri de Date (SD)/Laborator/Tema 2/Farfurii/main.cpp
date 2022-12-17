#include <fstream>
using namespace std;
ifstream citeste("farfurii.in");
ofstream scrie("farfurii.out");
long numar_farfurii, numar_tacamuri, farfurie_mutata, farfurii_crescatoare = 1;
int main()
{
    citeste >> numar_farfurii;
    citeste >> numar_tacamuri;
    while(farfurii_crescatoare*(farfurii_crescatoare-1)/2 < numar_tacamuri)
        farfurii_crescatoare++;
    for(long farfurie=1; farfurie<=numar_farfurii-farfurii_crescatoare; farfurie++)
        scrie << farfurie << " ";
    farfurie_mutata = numar_farfurii + numar_tacamuri - farfurii_crescatoare*(farfurii_crescatoare-1)/2;
    scrie << farfurie_mutata << " ";
    for(long farfurie=numar_farfurii; farfurie>numar_farfurii-farfurii_crescatoare; farfurie--)
        if(farfurie_mutata!=farfurie)
            scrie << farfurie << " ";
    return 0;
}
