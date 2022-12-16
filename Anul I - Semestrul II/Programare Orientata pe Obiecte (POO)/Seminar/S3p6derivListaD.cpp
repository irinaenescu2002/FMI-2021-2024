#include <iostream>
#include <fstream>
//exemplu mai  complex- clasa lista cu alocare dinamica din care deriva stiva si coada
using namespace std;

class lista
{protected:
    int *v;
    int max;
    int n;
 public:
    lista(){int d=10; max=d; n=0; v=new int[max]; cout<<"ci_l ";}
    lista(int d){max=d; n=0; v=new int[max]; cout<<"cip_l ";}
    lista(const lista & l){max= l.max; n=l.n; v= new int[max];
                           for(int i; i<n;i++) v[i]=l.v[i]; cout<<"cc_l ";
                           }
    lista operator =(lista l){delete []v;
                              max= l.max; n=l.n; v= new int[max];
                              for(int i; i<n;i++) v[i]=l.v[i];
                           }
   bool inserare(int val, int pos)
    {if (pos<0|| pos>n) return 0;
     if(n+1>max) return 0;// se poate aloca zona mai mare si copia inf
     for(int i=n-1;i>pos;i--){ v[i]=v[i-1];}
     v[pos]=val;
     return 1;
    }
};
class stiva: lista
{public:
   stiva(int d=10): lista(d){}
   bool push(int val){return inserare(val,n);}
};
class coadaI: protected lista /* coada ineficienta -stergerea unui element deplaseaza toate elementele */
{public:
    coadaI(int d=10):lista(d){}
   bool inserare(int val){return lista::inserare(val,n);}
};
class coadaE: protected lista /* coada eficienta -marcaj pentru inceput si sfarsit si deplasarea marcajelor */
{   int f,r;
 public:
    coadaE(int d=10):lista(d){f=r=-1; cout<<"ciP_cE ";}
/* Nu e nevoie de constructor de copiere si nici de operator= pentru ca se apeleaza
cele din baza, iar pentru datele suplimentare din derivata se copiaza bit cu bit */
    bool inserare(int val)
		{if (f==-1) f++;
		 r++;
		 return lista::inserare(val,r);
		}
};
class coadaEP: protected lista /* coada eficienta cu marcaje de tip pointer*/
{   int *pf,*pr;
 public:
    coadaEP(int d=10):lista(d){pf=pr=NULL; cout<<"ciP_cep ";}
    coadaEP(const coadaEP & c):lista(c)
		{pf=v+(c.pf-c.v); pr=v+(c.pr-c.v);cout<<"cc_cep ";}
/* diferenta pf-v =c.pf-c.v */
    coadaEP operator =(coadaEP  c)
    	{this->lista::operator =(c);
    	pf=v+(c.pf-c.v); pr=v+(c.pr-c.v);cout<<"o=cep ";
    }
    bool inserare(int val)
	{if(pf==NULL){pf=v;pr=v;}
	 else pr++;
	 lista::inserare(val,(pr-v));
	}
};// daca se aloca zona mai mare la depasire max -trebuiesc mutati si pf si pr pe noua zona !!


int main()
{/*lista l1;
    coadaI c1,c2(20);
    coadaE  c3(3),c4(c3); */
    coadaEP c5(20),c6(c5); c6=c5;
}

