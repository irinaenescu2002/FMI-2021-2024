/// ARORE BINAR DE CAUTARE SIMPLU CU OPERATIILE:
/// --> inserare valoare
/// --> cautare valoare
/// --> stergere valoare
/// --> succesorul unui numar
/// --> predecesorul unui numar
/// --> afisare in ordine sortata toate numerele cuprinse intre doua numere

#include <iostream>
#include <fstream>

using namespace std;

ifstream citeste("abce.in");
ofstream scrie("abce.out");

/// STRUCTURA UNUI NOD
/// -- valoare
/// -- pointer catre fiul stang
/// -- pointer catre fiul drept
/// -- pointer catre parintele lui

struct nod
{
    int valoare;
    nod *fiuStang;
    nod *fiuDrept;
    nod *parinte;
};


/// CREAREA UNUI NOD NOU
/// Setam doar valoarea nodului, urmatoarele detalii find stabilite la inserare.

nod *nodNou (int valoare)
{
    auto *nodCreat = new nod();
    nodCreat->valoare = valoare;
    nodCreat->fiuDrept = nullptr;
    nodCreat->fiuStang = nullptr;
    nodCreat->parinte = nullptr;
    return nodCreat;
}


/// INITIERE RADACINA
/// Initial radacina arborelui este null --> nu a fost inserata nici o valoare.

nod *radacina = nullptr;


/// INSERARE
/// Cream un nou nod, un nod pentru a retine parintele sau (initiat cu null) si un nod cu care
/// sa parcurgem arborele binar de cautare.
/// Parcurgem arborele binar de cautare pana gasim un nod fara fii, un nod disponibil la care sa atasam noul nod.
/// --> valoare mai mica decat a parintelui --> mergem in stanga
/// --> valoare mai mare decat a parintelui --> mergem in dreapta
/// La finalul parcurgerii, in nodParinte vom avea stocat parintele la care atasam nodul nou.
/// Ii salvam parintele nodului. Daca acesta este cumva null, inseamna ca noul nod este radacina.
/// Daca valoarea este mai mica il inseram in stanga, iar daca este mai mare il inseramin dreapta.

void inserare (int valoare)
{
    nod *nodInserat = nodNou(valoare);
    nod *viitorParinte = nullptr;
    nod *nodParcurgere = radacina;

    while (nodParcurgere != nullptr)
    {
        viitorParinte = nodParcurgere;
        if (nodInserat->valoare > nodParcurgere->valoare) nodParcurgere = nodParcurgere->fiuDrept;
        else nodParcurgere = nodParcurgere->fiuStang;
    }

    nodInserat->parinte = viitorParinte;
    if(viitorParinte == nullptr) radacina = nodInserat;
    else if (nodInserat->valoare > viitorParinte->valoare) viitorParinte->fiuDrept = nodInserat;
    else if (nodInserat->valoare < viitorParinte->valoare) viitorParinte->fiuStang = nodInserat;
}


/// CAUTARE
/// Pornim cautarea de la radacina.
/// Cat timp nu am ajuns la valoarea pe care o cautam si mai avem unde sa cautam, mergem:
/// --> in stanga daca valoare cautata este mai mica decat cea la care am ajuns
/// --> in dreapta daca valoare cautata este mai mare decat cea la care am ajuns

nod* cautareNod(int valoare)
{
    nod *nodParcurgere = radacina;

    while(nodParcurgere != nullptr && valoare != nodParcurgere->valoare)
    {
        if (valoare > nodParcurgere->valoare) nodParcurgere = nodParcurgere->fiuDrept;
        else nodParcurgere = nodParcurgere->fiuStang;
    }

    return nodParcurgere;
}

bool raspunsCautareNod(int valoareCautata)
{
    nod *verificare = cautareNod(valoareCautata);
    if(verificare == nullptr) return false;
    else return true;
}


/// VALOAREA MINIMA
/// Pentru a gasi valoarea minima mergem cat de in stanga putem.

nod* valoareaMinima(nod *nodParcurgere)
{
    while (nodParcurgere->fiuStang != nullptr) nodParcurgere = nodParcurgere->fiuStang;
    return nodParcurgere;
}


/// VALOAREA MAXIMA
/// Pentru a gasi valoarea minima mergem cat de in dreapta putem.

nod* valoareaMaxima(nod *nodParcurgere)
{
    while (nodParcurgere->fiuDrept != nullptr) nodParcurgere = nodParcurgere->fiuDrept;
    return nodParcurgere;
}


/// SUCCESOR
/// Pentru a gasi succesorul mergem o data in dreapta, apoi in stanga cat putem.
/// Practic, gasim valoarea minima din subarborele cu radacina fiului drept a nodului.
/// In cazul in care nu putem merge o singura data in dreapta, trebuie sa ne intoarcem la parinti
/// deoarece succesorul se va gasi in partea de sus a arborelui.

nod *succesor(int valoare)
{
    nod *nodCautare = cautareNod(valoare);

    if(nodCautare->fiuDrept != nullptr) return valoareaMinima(nodCautare->fiuDrept);

    nod *parinteSalvat = nodCautare->parinte;

    while(nodCautare == parinteSalvat->fiuDrept && parinteSalvat != nullptr)
    {
        nodCautare = parinteSalvat;
        parinteSalvat = parinteSalvat->parinte;
    }

    return parinteSalvat;
}


nod *predecesor(int valoare)
{
    nod *nodCautare = cautareNod(valoare);

    if(nodCautare->fiuStang != nullptr) return valoareaMaxima(nodCautare->fiuStang);

    nod *parinteSalvat = nodCautare->parinte;

    while(nodCautare == parinteSalvat->fiuStang && parinteSalvat != nullptr)
    {
        nodCautare = parinteSalvat;
        parinteSalvat = parinteSalvat->parinte;
    }

    return parinteSalvat;
}


/// STERGERE
/// Pentru stergere avem 3 cazuri:
/// 1. Nodul este frunza - il stergem pur si simplu
/// 2. Nodul are un copil - inlocuim nodul cu copilul sau si stergem copilul
/// 3. Nodul are doi copii - gasim succesorul lui, il inlocuim cu el si eliminam succesorul de la locul lui

nod *stergere(int valoare)
{
    if(raspunsCautareNod(valoare))
    {
        nod *nodSters = cautareNod(valoare);
        nod *nodSalvat1 = nullptr;
        nod *nodSalvat2 = nullptr;

        if(nodSters->fiuStang == nullptr || nodSters->fiuDrept == nullptr) nodSalvat1 = nodSters;
        else nodSalvat1 = succesor(nodSters->valoare);

        if(nodSalvat1->fiuStang != nullptr) nodSalvat2 = nodSalvat1->fiuStang;
        else nodSalvat2 = nodSalvat1->fiuDrept;

        if(nodSalvat2 != nullptr) nodSalvat2->parinte = nodSalvat1->parinte;

        if(nodSalvat1->parinte == nullptr) radacina = nodSalvat2;
        else if (nodSalvat1 == nodSalvat1->parinte->fiuStang) nodSalvat1->parinte->fiuStang = nodSalvat2;
        else nodSalvat1->parinte->fiuDrept = nodSalvat2;

        if(nodSalvat1 != nodSters) nodSters->valoare = nodSalvat1->valoare;
    }
}

/// PREDECESORUL UNUI NUMAR
/// Pornim cautarea de la radacina. Cautam cat timp mai avem unde sa cautam - nu am ajuns la un nod null.
/// -- Daca nodul la care am ajuns are valoarea ceruta il returnam.
/// -- Daca valoarea nodului la care am ajuns este mai mica, mergem spre dreapta
/// ---- Daca nu mai avem unde sa mergem in dreapta mai departe, inseamna ca am gasit predecesorul
/// ---- Daca mai avem unde sa mergem in dreapta mai departe
/// ------ Daca urmatorul nod are valoarea mai mica decat cea cautata, actualizam nodul cu urmatorul si mergem mai departe
/// ------ Daca urmatorul nod are valoarea mai mare decat cea cautata, trebuie sa mergem pe ramura lui stanga, deci actualizam nodul maxim cu urmatorul
/// -- Daca valoarea nodului la care am ajuns este mai mare, mergem spre stanga
/// ---- Daca nu mai avem unde sa mergem in stanga, inseamna ca am gasit predecesorul
/// ---- Daca mai avem unde sa mergem in stanga, actualizam nodul

int predecesorNumar (int valoare)
{
    nod *nodParcurgere = radacina;
    nod* valoareMaximaNod = radacina;

    while (nodParcurgere != nullptr)
    {
        if(nodParcurgere->valoare == valoare) return nodParcurgere->valoare;
        else if (nodParcurgere->valoare < valoare)
        {
            if(nodParcurgere->fiuDrept == nullptr)
            {
                if(nodParcurgere->valoare > valoare) return valoareMaximaNod->valoare;
                else return nodParcurgere->valoare;
            }
            else if (nodParcurgere->fiuDrept->valoare <= valoare) nodParcurgere = nodParcurgere->fiuDrept;
            else if (nodParcurgere->fiuDrept->valoare > valoare)
            {
                valoareMaximaNod = nodParcurgere;
                nodParcurgere = nodParcurgere->fiuDrept;
            }
        }
        else if (nodParcurgere->valoare > valoare)
        {
            if(nodParcurgere->fiuStang == nullptr)
            {
                if(nodParcurgere->valoare > valoare) return valoareMaximaNod->valoare;
                else return nodParcurgere->valoare;
            }
            else nodParcurgere = nodParcurgere->fiuStang;
        }
    }
}


///SUCCESORUL UNUI NUMAR
/// Rationamentul este acelasi, dar mergem in sens invers.

int succesorNumar (int valoare)
{
    nod *nodParcurgere = radacina;
    nod* valoareMinimaNod = radacina;

    while (nodParcurgere != nullptr)
    {
        if(nodParcurgere->valoare == valoare) return nodParcurgere->valoare;
        else if (nodParcurgere->valoare > valoare)
        {
            if(nodParcurgere->fiuStang == nullptr)
            {
                if(nodParcurgere->valoare < valoare) return valoareMinimaNod->valoare;
                else return nodParcurgere->valoare;
            }
            else if (nodParcurgere->fiuStang->valoare >= valoare) nodParcurgere = nodParcurgere->fiuStang;
            else if (nodParcurgere->fiuDrept->valoare < valoare)
            {
                valoareMinimaNod = nodParcurgere;
                nodParcurgere = nodParcurgere->fiuStang;
            }
        }
        else if (nodParcurgere->valoare < valoare)
        {
            if(nodParcurgere->fiuDrept == nullptr)
            {
                if(nodParcurgere->valoare < valoare) return valoareMinimaNod->valoare;
                else return nodParcurgere->valoare;
            }
            else nodParcurgere = nodParcurgere->fiuDrept;
        }
    }
}



int main()
{
    int q, op, x, y, numarPlecare, numarOprire;
    citeste >> q;
    for(int i=0; i<q; i++)
    {
        citeste >> op;
        cout << "Operatia " << op;
        if (op == 1)
        {
            cout << " - INSERARE\n";
            citeste >> x;
            inserare(x);
            cout << "Valoarea " << x << " a fost inserata.\n" << endl;
        }
        else if (op == 2)
        {
            cout << " - STERGERE\n";
            citeste >> x;
            stergere(x);
            cout << "Valoarea " << x << " a fost stearsa.\n" << endl;
        }
        else if (op == 3)
        {
            cout << " - CAUTARE\n";
            citeste >> x;
            if (raspunsCautareNod(x))
                scrie << "1\n";
            else
                scrie << "0\n";
            if (raspunsCautareNod(x))
                cout << "Valoarea " << x << " a fost gasita.\n" << endl;
            else
                cout << "Valoarea " << x << " nu a fost gasita.\n" << endl;

        }
        else if (op == 5)
        {
            cout << " - SUCCESORUL UNUI NUMAR\n";
            citeste >> x;
            scrie << succesorNumar(x) << endl;
            cout << "Succesorul din arbore al lui " << x << " este " << succesorNumar(x) <<".\n" << endl;

        }
        else if(op == 4)
        {
            cout << " - PREDECESORUL UNUI NUMAR\n";
            citeste >> x;
            scrie << predecesorNumar(x) << endl;
            cout << "Predecesorul din arbore al lui " << x << " este " << predecesorNumar(x) <<".\n" << endl;
        }
        else if (op == 6)
        {
            cout << " - NUMERELE DIN INTERVAL\n";
            citeste >> x >> y;
            numarPlecare = succesorNumar(x);
            numarOprire = predecesorNumar(y);
            cout << "Numerele din arbore din intervalul [" << x << ", " << y << "] sunt: ";
            while (numarPlecare < numarOprire)
            {
                cout << numarPlecare << " ";
                scrie << numarPlecare << " ";
                numarPlecare = succesorNumar(numarPlecare+1);
            }
            scrie << numarOprire << endl;
            cout << numarOprire << " \n" << endl;
        }
    }

    return 0;
}
