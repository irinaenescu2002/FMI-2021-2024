#include <cstdlib>
#include <iostream>
//exemplu de derivare : din clasa lista derivam clasa stiva si coada
using namespace std;
 
class lista
{ int v[100];
  protected: int l; // pentru ca e necesar accesul la l din clasele derivate
public:
lista(){l=0;} // va fi apelat de constructorul claselor derivate
bool insera(int val, int pos){/* completati*/}

bool sterge(int &val, int pos){/* completati*/}

};

class stiva : protected lista // nu e corecta derivarea publica - ar permite acces la inserare si stergere din lista -pe orice pozitie-nepotrivite pt stiva
{public:                               // se apeleaza implicit constructorul clasei de baza
  bool push(int val){return insera(val,l);};
  bool pop (int &val){return sterge(val,l-1);};
};

class coada : protected lista // functiile sterge si insera vor fi suprscrise dar  sunt accesibile (ex: lista::insera) 
{ public:                        
 bool insera(int val) {return lista::insera(val,l);};
 bool sterge(int & val) {return lista::sterge(val,0);};
};


int main()
{
}
