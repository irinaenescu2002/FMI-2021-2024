#include <iostream>

using namespace std;

/*class Baza {

    /// protected face sa am acces la variabile din clasele derivate

protected:
    int x, y;
    char z;

    /// dimensiunea e 12 deoarece se face o aliniere modulo 2
    /// dimensiunea unei clase >= suma dimensiunilor datelor membre
    /// daca sunt de acelasi tip - se aduna pur si simplu

public:
    void afis() {cout << "Baza " << x << "\n";}
};
*/

class Baza {

protected:
    int x, y;
    char z;

protected:
    void afis() {cout << "Baza " << x << "\n";}
};

// class Derivata : public Baza{};

/// caut in Derivata
/// daca nu gasesc in Derivata, ma duc la Baza
/// daca nu gasesc nici la Baza ma duc la tatal clasei Baza ... etc
/// (MOSTENIRE)

/// chiar daca nu am avea mai jos public, tot am avea acces la datele din Baza

class Derivata : public Baza{
int t;
public:
    void afis2() {cout << "Derivata\n" << x << "\n";}
    void afis() {cout << "D\n";}
};

/// se afiseaza D deoarece intai cauta la Derivata; cum gaseste functia, nu se duce la parinte
/// daca se comenteaza afis se va duce la functia afis de la Baza

class Derivata2 : public Derivata{};

int main()
{
    //Derivata ob;
    //cout << sizeof(ob) << endl;
    //ob.afis();
    //ob.afis();
    //ob.afis2();
    //Baza ob2;
    //ob2.afis();

    Derivata2 ob;
    ob.afis2();
    return 0;
}
