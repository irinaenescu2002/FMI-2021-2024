# Implementarea unui L-NFA

f = open("input.txt")
g = open("output.txt", "w")


# Citim numarul de stari ale automatului.
nrstari = int(f.readline())


# Citim starile automatului.
stari = [int(x) for x in f.readline().split()]


# Salvam starea maxima pentru a cunoaste cat spatiu alocam matricei de adiacenta.
dimensiune_mat = max(stari)


# Citim numarul de tranzitii ale automatului.
tranzitii = int(f.readline())


# Citim tranzitiile automatului, formand o lista de tupluri:
# (starea de unde plecam, starea in care ajungem, litera tranzitiei).
# In cazul in care avem o lambda tranzitie, citim lambda.
muchii = []
i = 0
while i < tranzitii:
    x, y, val = [x for x in f.readline().split()]
    muchii.append((int(x), int(y), val))
    i += 1


# Citim starea initiala.
stare_initiala = int(f.readline())


# Citim numarul de stari finale.
nrfinale = int(f.readline())


# Citim starile finale si le salvam intr-o lista.
stari_finale = [int(x) for x in f.readline().split()]


# Citim numarul de cuvinte pe care vrem sa le verificam.
nrcuv = int(f.readline())


# Citim cuvintele si le adaugam intr-o lista.
i = 0
cuvinte = []
while i < nrcuv:
    cuvinte.append(f.readline().strip())
    i += 1

# Initializam o matrice de liste nule. Am initializat matricea astfel deoarece
# intr-o stare se pot reintoarce mai multe valori si trebuie sa le retinem pe toate.
mat = [[[] for x in range(dimensiune_mat+1)] for y in range(dimensiune_mat+1)]


# Adaugam valori in matrice astfel:
# mat[stare_de_unde_plecam][stare_unde_ajungem] = [lista cu valorile pe care le putem avea]
for muchie in muchii:
    mat[muchie[0]][muchie[1]].append(muchie[2])


# Aflam multimea de stari in care se poate ajunge plecand din starea q
# si aplicand 0 sau mai multe lambda tranzitii
def lambda_tranzitii(stare_curenta):
    for stare2 in stari:
        if 'lambda' in mat[stare_curenta][stare2]:
            inchidere_stare.append(stare2)
            lambda_tranzitii(stare2)


dictionar_inchidere = {}
for stare in stari:
    dictionar_inchidere[stare] = None
for stare in stari:
    inchidere_stare = [stare]
    lambda_tranzitii(stare)
    dictionar_inchidere[stare] = set(inchidere_stare)


def parcurgere(multime_stari, cuvant):
    global ok
    global multime_lambda
    multime_lambda = set()
    global multime_litera
    multime_litera = set()
    global multime_litera_salvata
    if cuvant != '':
        for element in multime_stari:
            for stare in dictionar_inchidere[element]:
                multime_lambda.add(stare)
        print(multime_lambda)
        for element in multime_lambda:
            for stare in stari:
                if cuvant[0] in mat[element][stare]:
                    multime_litera.add(stare)
        print(multime_litera)
        multime_litera_salvata = multime_litera
        cuvant = cuvant[1:]
        parcurgere(multime_litera, cuvant)
    else:
        for element in multime_litera_salvata:
            for stare in dictionar_inchidere[element]:
                multime_lambda.add(stare)
        print(multime_lambda, '\n')
        for stare_finala in stari_finale:
            if stare_finala in multime_lambda:
                ok = True


# Daca avem cuvantul vid, iar starea initiala este si stare finala, inseamna ca este acceptat.
# Daca starea initiala nu este si finala, cuvantul vid nu este acceptat.
# Daca cuvantul nu este vid, pentru fiecare cuvant apelam functia de verificare.
for cuvant in cuvinte:
    if len(cuvant) == 0:
        if stare_initiala in stari_finale:
            g.write("Da\n")
        else:
            g.write("Nu\n")
    else:
        # Presupunem cuvantul ca fiind neacceptat.
        ok = False
        multime = set()
        multime.add(stare_initiala)
        parcurgere(multime, cuvant)
        # Daca ok nu a fost modificat in functie (daca nu exista nici un drum pana la o stare
        # finala pentru a verifica cuvantul), cuvantul nu este acceptat, altfel este acceptat.
        if ok is False:
            g.write("Nu\n")
        else:
            g.write("Da\n")
