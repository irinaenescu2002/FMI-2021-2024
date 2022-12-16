#include <iostream>

using namespace std;

class Baza {
public:
    virtual void afis() {cout << "Baza\n";}
    virtual void f() {};

};

class Derivata : public Baza{
public:
    void afis() {cout << "Derivata\n";}
    virtual void g() {};

};


int main()
{
    cout << sizeof(Baza) << endl;
    /// fara virtual => 1
    /// cu virtual => 8

    Baza *p;
    p = new Derivata ();
    p->afis();
    /// fara virtual => Baza
    /// cu virtual => Derivata

    /// p -> g();
    // a fost facuta mai tarziu, deci nu e inclusa in pointer => NU MERGEEE
    return 0;
}
