#include <iostream>
#include <string>
#include <vector>
using namespace std;

class IDCustom {
    static int id;
public:
    IDCustom() = delete;

    static int getId() {
        return id++;
    }
};
int IDCustom::id = 0;


class Produs {
    string denProdus;
    float pretProd;
public:
    Produs(string d = "", float p = 0);
    const string getDenProdus() const {
        return denProdus;
    }
    const float getPretProd() const {
        return pretProd;
    }
    void setDenProdus(string t) {
        denProdus = t;
    }
    void setPretProd(float t) {
        pretProd = t;
    }

    Produs& operator=(const Produs& p) {
        denProdus = p.getDenProdus();
        pretProd = p.getPretProd();
    }

    friend ostream& operator<<(ostream& os,const Produs& p) {
        os << p.getDenProdus() << " " << p.getPretProd() << " ";
        return os;
    }

};
Produs::Produs(string d, float p) : denProdus(d), pretProd(p) {};


class Comanda {
    Produs Prod;
    int Num, nrPortii;
    struct date {
        int zi, luna, an;
    }data;
public:
    Comanda(string s = "", int p = 0, int z = 31, int l = 5, int a = 2016)
    : nrPortii(p) {
        Prod.setDenProdus(s);
        data.zi = z;
        data.luna = l;
        data.an = a;
        Num = IDCustom::getId();
    }

    Comanda(Comanda& c) {
        Prod = c.Prod;
        nrPortii = c.getNrPortii();
        data = c.getData();
    }

    const int getNum() const {
        return Num;
    }

    const int getNrPortii() const {
        return nrPortii;
    }

    const date getData() const {
        return data;
    }

    const Produs getProd() const {
        return Prod;
    }

    void del() {
        nrPortii = 0;
    }

    Comanda& operator=( Comanda& c) {
        Num = c.getNum();
        nrPortii = c.getNrPortii();
        data = c.getData();
        Prod = c.getProd();

        return *this;
    }

    Comanda& operator+(int n) {
        nrPortii += n;
        return *this;
    }

    Comanda& operator++() {
        nrPortii++;
        return *this;
    }

    Comanda& operator++(int) {
        Comanda aux = *this;
        ++*this;
        return aux;
    }

    friend istream& operator>>(istream& is, Comanda& c) {
        string t;
        cout << "Produs: ";is >> t;
        c.Prod.setDenProdus(t);
        cout << "Nr portii";is >> c.nrPortii;
        return is;
    }

    friend ostream& operator<<(ostream& os, Comanda& c) {
        os << c.getProd() << " " << c.getNrPortii() << " ";
        os << c.data.zi << "-" << c.data.luna << "-" << c.data.an << " ";
        return os;
    }
};

class Ospatar {
    string Nume;
    Comanda* comenzi;
    int nrComenzi, varsta;
    char gen;
public:
    Ospatar(string n, Comanda* c, int cc, char g, int v)
    : Nume(n), comenzi(c), nrComenzi(cc), gen(g), varsta(v) {};

    friend ostream& operator<<(ostream& os, Ospatar& o) {
        os << "Nume: ";os << o.Nume;
        os << "Nr comenzi: ";os << o.nrComenzi;
        os << "Varsta ";os << o.varsta;
        os << "Gen: ";os << o.gen;
        return os;
    }

    const string nume() const {
        return Nume;
    }

    bool operator>( Ospatar& o2) {
        return nrComenzi > o2.nrComenzi;
    }

    bool operator==( Ospatar& o2) {
        return nrComenzi == o2.nrComenzi;
    }
};

int main() {
    Produs meniu[4] = { Produs("frigarui", 30), Produs("cola",7.5), Produs("cafea",5) };
    Comanda c1("frigarui", 2, 31, 5, 2016), c2("cola",3), c3("cafea",1), c4 = c2, c5;
    c3 = c3 + 4; // se comanda încă 4 cafele
    c2++; // se mai comandă o cola
    c1.del(); //se anulează comanda c1
    cin >> c5;
    cout << c4 << endl << c5; //se afișează comanzile c4 și c5

    Comanda *com1 = new Comanda[4], *com2 = new Comanda[4];

    com1[0] = c1; com1[1] = c2; com1[2] = c3; com2[0] = c4; com2[1] = c5;

    Ospatar o1("Ionescu",com1,3,'M',25), o2("Popescu",com2,2,'F',30);

    cout << o1 << o2;

    if (o2 > o1)
     cout << "Ospatarul " << o2.nume() << "a servit mai multe comenzi decat ospatarul " << o1.nume() << endl;
    else if (o2 == o1) cout << "Numar egal de comenzi intre ospatarii " << o2.nume() << "si " << o1.nume() << endl;
    else cout << "Ospatarul " << o2.nume() << "a servit mai puține comenzi decat ospatarul " << o1.nume() << endl;

    return 0;
}
