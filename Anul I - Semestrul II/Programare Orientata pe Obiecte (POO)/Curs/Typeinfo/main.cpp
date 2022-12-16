#include <iostream>
#include<typeinfo>

using namespace std;

class Baza {
public:
    virtual void f() {};
};

class Derivata : public Baza{};

int main()
{
    int x;
    float y;
    Baza b, *p;
    Derivata d;

  //  cout << typeid(x).name() << endl;
  //  cout << typeid(y).name() << endl;
  //  cout << typeid(b).name() << endl;
  //  cout << typeid(d).name() << endl;
  //  cout << typeid(p).name() << endl;
  //  cout << typeid(*p).name() << endl; /// adresa unui obiect de tip baza

    p = &d; /// upcasting

    cout << typeid(p).name() << endl;

    cout << typeid(*p).name() << endl;
    /// => 8Derivata daca avem virtual void f()
    /// => 4Baza daca nu avem virtual void f()

    p = new Baza();
    cout << typeid(*p).name() << endl;
    /// => 4Baza

    cout << endl << endl;

    Derivata *dd;

    /// dd = dynamic_cast<Derivata>(&b); -> nu merge decat pe anumite cazuri (tentativa de downcasting)

    dd = dynamic_cast<Derivata*>(p);
    /// daca nu aveam functia virtuala, nu mergea !!

    return 0;
}
