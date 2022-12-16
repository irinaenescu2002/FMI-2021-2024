#include <cstdlib>
#include <iostream>
#include <cmath>
using namespace std;

class Complex
{
      float re,im;
public:
     Complex(){im=0; }
     Complex (int r){re=r;im=0;}
     Complex(int r,int i){re=r;im=i;}
     /* -operator e o functie cu simbol si forma de apel speciala -prefixat,infixat sau postfixat
     - trebuie pastrat numarul de operanzi
     - poate transmite parametrii prin valoare sau referinta si poate intoarce rezultatul prin valoare sau referinta
     - se pot supraincarca prin 
        functii exterioare (nr parametrii =nr de operanzi) sau 
        metode (primul operand este obiectul care apeleaza metoda si restul operanzilor =parametrii)
    */
     
     friend Complex& operator+(const float & i,const Complex &p2 ); 
   // functie exterioara care primeste drepturi de acces la datele private si protejate ale clasei
   //se declara dreptul de friend in clasa si se defineste in afara clasei
     Complex operator+(Complex p2); 
        //primul operand devine obiectul care apeleaza metoda operator+
    	// doar al doilea operand ramane parametru
    Complex operator = (Complex p); 
   // supraincarcare DOAR ca metoda a clasei
     	// intoarce un obiect al clasei pentru a permite atribuire repetata ex: C1=C2=C3;
     //poate fi vazuta ca C1.=(C2.=(C3))
     friend istream & operator>>(istream & i, Complex &op); 
    // parametrii transmisi prin referinta pentru ca ambii se modifica
 	//rezultat intors prin referinta pentru a putea fi apelat ca parametru de intrare pentru urmatorul operator in cazul citirii multiple
	 // exemplu  cin>>C1 >>C2; il gindim ca >>(>>(cin,C1), C2)
     friend ostream & operator<<(ostream & out,const Complex & op);
      /* referinta care protejeaza zona pentru a putea apela cu valori temporare intoarse de functii 
posibil transmitere si prin valoare dar mai putin eficienta pentru clase derivate */
     float & operator[](int i); // intors prin referinta pentru a fi l-valoare (poate primi valori)
	     operator float(){return sqrt(re*re+im*im);} /* operatorul de conversie la tip- DOAR ca metoda, nu se scrie tipul intors
   	  iar numele operatorului este tipul catre care se face conversia ;
     Nu pot exista in acelasi timp operatorul de conversie la float si op + catre float -ambiguitate la apel s1+2 */
};

Complex Complex :: operator + (Complex p2)
{ Complex ol;
   ol.re=re+p2.re; // ol.re=(*this).re +p2.re;
   ol.im=im+p2.im;
  return ol;
 }

Complex& operator + (const float &r,const Complex & p2)
//apel eficient prin referinta care protejeaza zona -pentru a putea apela obiecte constante si temporare
{/*-nu pot intoarce alt nume pt variabila locala aflata pe stiva-zona va fi alocata pentru alte apeluri de functie
  -necesar alocare zona dinamica -ramane alocata si dupa terminarea functiei- pana la apelul operator delete
 */
 Complex *pl=new Complex; 
  pl->re=r+p2.re;
  pl->im=p2.im;
   return *pl;
}
Complex Complex:: operator=(Complex p)
{re=p.re;
 im=p.im;
return (*this);}

istream & operator >>(istream & i, Complex &op)
{ i>>op.re>>op.im;
  return i;
}
ostream & operator <<(ostream & out,const Complex &op)
{ out<<op.re<<op.im;
  return out;
}

 float & Complex :: operator[](int i)
{if(i==0) return re;
  return im;}

int main()
{ Complex C1, C2(1,2), C3(2,3);
   C1+C2; // C1.operator+(C2)
   // C1+2; //ambiguitate intre operator+ si operator de conversie 
   2+C2; //  operator+(2,C2)
   C1=C2=C3;
   cin>>C1;   //operator>>(cin,C1); /* e permis si apelul prefixat*/
   C1[0]=2;C1[1]=3;
   int a=C1;
}


