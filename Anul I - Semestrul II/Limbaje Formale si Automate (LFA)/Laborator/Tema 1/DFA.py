# Implementarea unui DFA (AFD)

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


# Initializam o lista vida pentru a afisa si drumul parcurs pentru verificarea cuvantului.
drum = []

# Daca avem cuvantul vid, iar starea initiala este si stare finala, inseamna ca este acceptat.
# Daca starea initiala nu este si finala, cuvantul vid nu este acceptat.
# Daca cuvantul nu este vid, pentru fiecare cuvant setam nodul curent starea initiala,
# adaugandu-l la drum si il salvam intr-o variabila auxiliara din care vom elimina pas cu pas litera parcursa.
# Astfel putem verifica daca s-a parcurs tot cuvantul, evitand situatia in care nodul curent ramane blocat
# la o stare finala, avand ulterior litere ce nu corespund unei tranzitii bune.
# Pentru fiecare litera in cuvant, pentru fiecare stare viitoare, verificam daca gasim litera
# corespunzatoare intr-o tranzitie.
# Daca o gasim, actualizam nodul curent cu cel gasit si il adaugam la drum, apoi oprim cautarea
# si trecem la urmatoarea litera.
# Dupa ce am verificat toate literele, daca nodul curent se afla in starile finale,
# cuvantul este acceptat si putem afisa drumul, altfel nu.
for cuvant in cuvinte:
    if len(cuvant) == 0:
        if stare_initiala in stari_finale:
            g.write("Da -> " + str(stare_initiala) + "\n")
        else:
            g.write("Nu\n")
    else:
        nod_curent = stare_initiala
        index = 0
        salv = cuvant
        drum.append(nod_curent)
        while index < len(cuvant):
            for j in range(dimensiune_mat+1):
                if cuvant[index] in mat[nod_curent][j]:
                    nod_curent = j
                    salv = salv[1:]
                    drum.append(nod_curent)
                    break
            index += 1
        if nod_curent in stari_finale and len(salv) == 0:
            g.write("Da -> ")
            for x in drum:
                g.write(str(x) + " ")
            g.write("\n")
            drum = []
        else:
            g.write("Nu\n")
            drum = []


f.close()
g.close()
