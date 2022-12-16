#include <cstdlib>
#include <iostream>
#include<cstring>
using namespace std;
// exemplu pentru compunere clasa sir si clasa Persoana care are data NumePrenume de tip sir 
class lista
{protected:
    char *v;
    int max;
    int n;
 public:
    lista(){int d=10; max=d; n=0; v=new char[max]; }
    lista(int d){max=d; n=0; v=new char[max]; }
    lista(const char *s){n=strlen(s); max=n+1; v= new char[max]; strcpy(v,s);}
    lista(const lista & l){max= l.max; n=l.n; v= new char[max];
                           strcpy(v, l.v);
                           }
    lista operator =(lista l){delete []v;
                              max= l.max; n=l.n; v= new char[max];
                              strcpy(v,l.v);
                           }
};
class Persoana
{lista NumePrenume;
 int varsta;
 public:
 Persoana(): varsta(0){}
 Persoana(lista np, int v):NumePrenume(np),varsta(v){}
 /* constr copiere dat de compilator apeleaza constr de copiere pt date mb iar varsta se copiaza bit cu bit */
 /* op = dat de compilator apeleaza op = pt date mb si copiaza varsta bit cu bit*/
};

class Student
{ lista NumePrenume;
  float * medii;
  int nrMedii;
public:
  Student(lista np="",int nm=10 ): NumePrenume(np),nrMedii(nm) /* apel constructor de initializare date mb  */
   {medii= new float [nm];}
  Student(const Student & s): NumePrenume(s.NumePrenume),nrMedii(s.nrMedii) /* apel constructor de copiere date mb */
   {medii=new float [nrMedii];
    for(int i=0;i<nrMedii;i++) medii[i]=s.medii[i];
   }
  Student operator = (Student s)
   {NumePrenume=s.NumePrenume;
	nrMedii=s.nrMedii;
	medii=new float [nrMedii];
    for(int i=0;i<nrMedii;i++) medii[i]=s.medii[i];
    return *this;
    }
};
int main()
{ Persoana X("Ion",10);
  Student Y("Ion", 3);
}

