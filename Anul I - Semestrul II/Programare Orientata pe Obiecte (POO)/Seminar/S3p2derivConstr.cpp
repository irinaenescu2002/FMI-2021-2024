#include <cstdlib>
#include <iostream>
using namespace std;

// Apelul constructorilor de initializare si copiere, al operatorilor= si destructorilor in clasa derivata 

class B
{
 public:
  B(int i=0){cout<<" c i baza \n";}
  B(const B& b){cout<<" c copiere baza \n ";}
  void operator=(const B &ob){cout<<" = baza\n";}
  ~B(){cout<<"destructor baza\n ";}
  };
 
 class D :B /* specificator mostenire -implicit privat */
 { public :
  /* se apeleaza automat intai constructorul pt  baza si apoi pentru derivata */
   /* ordinea e cea din lista de derivare -indiferent de ordinea din lista de apel explicit a constructorilor */
 D(int i=0)//: B(i);   /* apel explicit - transmit parametrii catre constructorul clasei de baza */
  {cout<<" c i derivata \n";}
   
/* constructorul  de copiere al derivatei dat de compilator apeleaza constructorul de COPIERE al bazei */
    /* constructorul de copiere al derivatei scris de programator -IMPLICIT apeleaza constructorul de INITIALIZARE al bazei,
       deci trebuie apelat EXPLICIT cel de copiere */
    D(const D &d)//:B(d) /* apel explicit -parametrul este referinta(alt nume) la partea de baza a lui d */
   {cout<<" c copiere derivata \n";}

 void operator=(const D & od )
 { /*  *this=od; ar apela infinit  operatorul = din D */
    (B &)(*this)=od ; /* apel explicit al operatorui = din B; 
    Necesar conversie catre baza, operatorul de conversie avand rezultat intors prin referinta;
    Daca se face conversie spre B , operatorul de conversie avand rezulatul intors prin valoare
    se va intoarce un temporar = o copie  a lui (*this) ). */
 
   B &rb=(*this); rb=od; /* alta varianta- se copie doar partea de baza din od in partea de baza din obiectul implicit */
   (*this).B::operator=(od); /* alta varianta - apel explicit al op = din B */
    cout<<"= derivata\n";
}
 /* operatorul = dat de compilator  al derivatei  -apeleaza operatorul= al bazei */
 /* operatorul = scris de programator al derivatei-IMPLICIT-NU apeleaza operatorul = al bazei, deci trebuie apelat EXPLICIT 
 sau facute copierile respective*/
 
~D(){cout<<"destructor derivata \n ";}
 /*destructorul implicit sau definit  apeleaza destructorul bazei */
 /* ordinea de executie este INVERSA fata de cea a constructorilor */
       };

D::D(int i):B(i){}



class C /*  Compunerea are acces doar la datele publice  ale m1 si m2 */
{B m1,m2;
public:
/* se apelaza intai constructorul pt baza, apoi pentru membrii, apoi constructorul pentru clasa C,
	indiferent de ordinea din lista de apel explicit*/
   C(int i=0): m1(i) 
  {cout<<"initializare C \n";}
   /* prin apelul explicit pot trimite si parametrii */
   
	C(const C & oc):m1(oc.m1){cout<<"copiere C\n";}
   /* constr copiere dat de compilator al clasei compuse -implicit apeleaza constructorii de copiere ai claselor datelor membre */
   /* constr de copiere scris de programator al clasei compuse-IMPLICIT apeleaza constructorii de INITIALIZARE ai claselor datelor membre
     -deci trebuie apelati  EXPLICIT  constructorii de copiere ai claselor datelor membre */

    void operator =(const C & oc){cout<<"egal C\n "; 
								  (*this).m1=oc.m1;
										  m2=oc.m2;}
/* operatorul = dat de compilator al clasei compuse implicit-apeleaza operatorii = ai claselor membre */
/* operatorul = scris de programator al clasei compuse -IMPLICIT-NU apeleaza operatorii = ai claselor membre,
   deci  trebuie apelati explicit */
};

int main(int argc, char *argv[])
{
    D d1,d2=d1; 
    d1=d2; 
    C c1, c2=c1;
    c1=c2;
    return 0;
}
