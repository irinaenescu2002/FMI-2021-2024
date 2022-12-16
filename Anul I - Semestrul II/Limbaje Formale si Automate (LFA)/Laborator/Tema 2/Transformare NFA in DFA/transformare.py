# Transformare NFA in DFA

f = open("input.txt")
g = open("output.txt", "w")

nfa = {}

# Citim numarul de stari ale automatului.
nrstari = int(f.readline())


# Citim starile automatului si initiem dictionarul.
stari = [x for x in f.readline().split()]
for stare in stari:
    nfa[stare] = {}


# Salvam starea maxima pentru a cunoaste cat spatiu alocam matricei de adiacenta.
dimensiune_mat = max(stari)


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
        nfa[x][val] = []
for elem in lista_tranzitii:
    x = elem[0]
    y = elem[1]
    val = elem[2]
    nfa[x][val].append(y)
for x in stari:
    for val in valori:
        nfa[x][val].sort()


# Citim starea initiala.
stare_initiala = f.readline().strip()


# Citim numarul de stari finale.
nrfinale = int(f.readline())


# Citim starile finale si le salvam intr-o lista.
stari_finale = [x for x in f.readline().split()]
stari_finale.sort()


# Afisam NFA
print()
print("NFA")
print("--------------------------------------------------------", end="")
print("------------------------------------------------------------------------------")
print("Tranzitiile automatului sunt date sub forma unui dictionar ", end="")
print("{Stare automat: {valoare: [stari in care se poate ajunge cu acea valoare]}}")
print("Tranzitii: ", nfa)
print(f"Stare initiala: {stare_initiala}")
print(f"Stari finale: {stari_finale}\n")


# Construim acelasi sablon de dictionar si pentru DFA.
# Salvam starile noi ce trebuie adaugate intr-o lista separata.
dfa = {}
stari_noi_dfa = []
dfa[stare_initiala] = {}

# Pentru fiecare valoare posibila uni tranzitii, plecam cu initierea transformarii
# din starea initiala, adaugand starile noi ce deriva din aceasta.
for val in valori:
    aux = ''
    for stare_sosire in nfa[stare_initiala][val]:
        aux += stare_sosire
    dfa[stare_initiala][val] = aux
    if aux not in stari and aux != '':
        stari_noi_dfa.append(aux)


# Cat timp mai avem de prelucrat stari noi, le compunem pentru fiecare valoare cu ajutorul
# dictionarului in care am salvat NFA-ul.
# Avem grija ca formarea starilor sa fie in ordonata pentru a evita duplicatele.
while len(stari_noi_dfa) != 0:
    for stare_noua in stari_noi_dfa:
        dfa[stare_noua] = {}
        for valoare in valori:
            maux = []
            aux = ''
            for elem in stare_noua:
                for vall in nfa[elem][valoare]:
                    if vall not in maux:
                        maux.append(vall)
            maux.sort()
            for elem in maux:
                aux += elem
            dfa[stare_noua][valoare] = aux
            if aux not in dfa.keys():
                stari_noi_dfa.append(aux)
        stari_noi_dfa.remove(stare_noua)

# Cautam noile stari finale (cele care contin starile finale initiale).
stari_noi_finale_dfa = []
for stare_initiala_finala in stari_finale:
    for stare_noua_finala in dfa.keys():
        if stare_initiala_finala in stare_noua_finala:
            stari_noi_finale_dfa.append(stare_noua_finala)

# Afisam DFA
print("DFA")
print("--------------------------------------------------------", end="")
print("------------------------------------------------------------------------------")
print("Tranzitiile automatului sunt date sub forma unui dictionar ", end="")
print("{Stare automat: {valoare: [stari in care se poate ajunge cu acea valoare]}}")
print("Tranzitii: ", dfa)
print(f"Stare initiala: {stare_initiala}")
print(f"Stari finale: {stari_noi_finale_dfa}")
