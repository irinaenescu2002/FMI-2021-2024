# Implementarea unui NFA (AFN)

f = open("input2.txt")
g = open("output2.txt", "w")


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

# Salvam cuvantul initial intr-o variabila auxiliara.
# Pornind de la starea initiala, pentru fiecare stare a automatului
# verificam daca exista o tranzitie corespunzatoare
# pentru prima litera a cuvantului.
# Daca nu exista, functia ia sfarsit repede dupa parcurgere,
# ok-ul nu se modifica, deci cuvantul nu e acceptat.
# Daca da, bifam prima litera si o stergem, actualizand astfel
# cuvantul pe care o sa il parcurgem cu aceeasi functie.
# Daca am parcurs tot cuvantul si ajungem intr-o stare finala, cuvantul este
# acceptat, deci modificam ok-ul si iesim din functie, verificarea luand sfarsit.
# Daca nu am parcurs tot cuvantul, reapelam pentru starea in care am gasit legatura si cuvantul curent.
# Daca am luat-o pe o tranzitie gresita si intr-un final functia nu s-a oprit (nu a acceptat cuvantul),
# ne intoarcem la cuvantul anterior folosind salvarea de la inceputul functiei
# si cautam stari in continuare, reluand algoritmul.


def dfs(nod_curent, cuvant_curent):
    global ok
    aux = cuvant_curent
    for j in stari:
        if aux[0] in mat[nod_curent][j]:
            aux = aux[1:]
            if len(aux) == 0:
                if j in stari_finale:
                    ok = True
                break
            dfs(j, aux)
            aux = cuvant_curent


# Daca avem cuvantul vid, iar starea initiala este si stare finala, inseamna ca este acceptat.
# Daca starea initiala nu este si finala, cuvantul vid nu este acceptat.
# Daca cuvantul nu este vid, pentru fiecare cuvant apelam functia de verificare.
for cuvant in cuvinte:
    if len(cuvant) == 0:
        if stare_initiala in stari_finale:
            g.write("Da -> " + str(stare_initiala) + "\n")
        else:
            g.write("Nu\n")
    else:
        # Presupunem cuvantul ca fiind neacceptat.
        ok = False
        dfs(stare_initiala, cuvant)
        # Daca ok nu a fost modificat in functie (daca nu exista nici un drum pana la o stare
        # finala pentru a verifica cuvantul), cuvantul nu este acceptat, altfel este acceptat.
        if ok is False:
            g.write("Nu\n")
        else:
            g.write("Da\n")
