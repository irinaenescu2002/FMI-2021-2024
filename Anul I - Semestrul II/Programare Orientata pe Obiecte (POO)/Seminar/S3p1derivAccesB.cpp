#include <cstdlib>
#include <iostream>
using namespace std;
//Accesul la datele din baza B in clasa derivata D si respectiv compusa C

class B
{private: int v;    /* accesibil DOAR  din metodele clasei B */
 protected: int d; /* pentru obiect din B (la fel ca si private) accesibil DOAR din metodele clasei B*/
                  /* pentru obiect din D (derivata din B) accesibil din metodele clasei D */
 public: int b; /* accesibil din orice punct al programului */
 };
 class D :B /* clasa D  ESTE ca  B (are toate datele si metodele lui B) plus date si metode suplimentare */
			/* specificator mostenire -implicit privat */
 { public :
  void f()
   {//v=3; /*  este inaccesibil */
    d=3;
    D d1;
    d1.d=3;/* este accesibil */ 
    B b1;
    // b1.d=3; /* nu este accesibil !!!!*/
    }

};

class C // clasa C  ARE doua date de tip B

{B m1,m2;
public: void g()
 {//m1.v=1;m1.d=1; /* datele private sau protected ale datelor membre sunt inaccesibile */
  m1.b=1;  /*are acces doar la datele publice  ale m1 si m2 */
 }
};

class BC: public B, C{};// va mosteni public doar B si PRIVAT pe C

int main(int argc, char *argv[])
{
 system("PAUSE");
    return 0;
}





