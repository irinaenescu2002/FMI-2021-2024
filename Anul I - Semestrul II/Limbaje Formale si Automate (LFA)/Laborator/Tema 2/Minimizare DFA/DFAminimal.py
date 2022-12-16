# Minimizare DFA

f = open("input.txt")
g = open("output.txt", "w")

dfa = {}

# Citim numarul de stari ale automatului.
nrstari = int(f.readline())


# Citim starile automatului si initiem dictionarul.
stari = [x for x in f.readline().split()]
for stare in stari:
    dfa[stare] = {}


# Citim numarul de tranzitii ale automatului.
tranzitii = int(f.readline())


# Citim tranzitiile automatului, formand o lista de tupluri si
# salvam valorile posibile pentru tranzitii:
i = 0
valori = []
lista_tranzitii = []
while i < tranzitii:
    x, y, val = [x for x in f.readline().split()]
    lista_tranzitii.append((x, y, val))
    if val not in valori:
        valori.append(val)
    i += 1
valori.sort()


# Formam un dictionar de forma:
# {Stare automat: {valoare: [stari in care se poate ajunge cu acea valoare]}}"
for x in stari:
    for val in valori:
        dfa[x][val] = None
for elem in lista_tranzitii:
    x = elem[0]
    y = elem[1]
    val = elem[2]
    dfa[x][val] = y

# Citim starea initiala.
stare_initiala = f.readline().strip()


# Citim numarul de stari finale.
nrfinale = int(f.readline())


# Citim starile finale si le salvam intr-o lista.
stari_finale = [x for x in f.readline().split()]
stari_finale.sort()


# Salvam starile nefinale.
stari_nefinale = []
for stare in stari:
    if stare not in stari_finale:
        stari_nefinale.append(stare)


# Afisam DFA
print()
print("DFA")
print("--------------------------------------------------------", end="")
print("------------------------------------------------------------------------------")
print("Tranzitiile automatului sunt date sub forma unui dictionar ", end="")
print("{Stare automat: {valoare: starea in care se ajunge cu acea valoare}}")
print("Tranzitii: ", dfa)
print(f"Stare initiala: {stare_initiala}")
print(f"Stari finale: {stari_finale}")
print(f"Stari nefinale: {stari_nefinale}\n")


# Partitionam multimea starilor in partitii din ce in ce mai mici
# astfel incat la final fiecare partitie sa aiba stari echivalente intre ele.
minimizare = []
copie_minimizare = []
minimizare.append(stari_nefinale)
minimizare.append(stari_finale)
ok = True
while ok:
    for lista_stari in minimizare:
        reper = lista_stari[0]
        multime_provenienta = []
        aux = set()
        auxx = set()
        for elem in lista_stari:
            for valoare in valori:
                loc = dfa[reper][valoare]
                for apartenenta in minimizare:
                    if loc in apartenenta:
                        multime_provenienta = apartenenta
                if dfa[elem][valoare] not in multime_provenienta:
                    aux.add(elem)
                else:
                    auxx.add(elem)
        if len(auxx) != 0:
            copie_minimizare.append(sorted(list(auxx)))
        if len(aux) != 0:
            copie_minimizare.append(sorted(list(aux)))
    minimizare.sort()
    copie_minimizare.sort()
    if minimizare == copie_minimizare:
        ok = False
    minimizare = copie_minimizare
    copie_minimizare = []


# Facem un nou automat dupa aceeasi structura.
dfa_minimizat = {}


# Salvam starile noi ale automatului, stari obtinute in lista de minimizare.
stari_noi = []
for lista in minimizare:
    stare_noua = ""
    for elem in lista:
        stare_noua += elem
    stari_noi.append(stare_noua)


# Salvam starea initiala noua.
stare_initiala_noua = ""
for elem in stari_noi:
    if stare_initiala in elem:
        stare_initiala_noua = elem


# Salvam noile stari finale.
stari_finale_noi_m = set()
for elem in stari_noi:
    for lit in elem:
        if lit in stari_finale:
            stari_finale_noi_m.add(elem)
stari_finale_noi = list(stari_finale_noi_m)


# Facem initierea automatului.
for stare in stari_noi:
    dfa_minimizat[stare] = {}


# Salvam starile simple (cele care nu s-au modificat).
# Adaugam starile noi compuse cu stari echivalente folosind valorile unei stari din compunere.
for stare in dfa_minimizat:
    if stare in dfa.keys():
        dfa_minimizat[stare] = dfa[stare]
    else:
        cheie = stare[0]
        dfa_minimizat[stare] = dfa[cheie]


# Actualizam starile noi compuse cu valorile noi corespunzatoare.
for stare in stari_noi:
    for valoare in valori:
        if dfa_minimizat[stare][valoare] not in dfa_minimizat.keys():
            val = dfa_minimizat[stare][valoare]
            for cheie in dfa_minimizat.keys():
                if val in cheie:
                    dfa_minimizat[stare][valoare] = cheie


# Afisam DFA MINIMIZAT
print()
print("DFA MINIMIZAT")
print("--------------------------------------------------------", end="")
print("------------------------------------------------------------------------------")
print("Tranzitiile automatului sunt date sub forma unui dictionar ", end="")
print("{Stare automat: {valoare: starea in care se ajunge cu acea valoare}}")
print("Tranzitii: ", dfa_minimizat)
print(f"Stare initiala: {stare_initiala_noua}")
print(f"Stari finale: {stari_finale_noi}")
