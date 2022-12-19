# COURSE SCHEDULE II

# --------------------------------------------- SUBPUNCTUL A -------------------------------------------------

# Folosim un dictionar pentru a face lista de adiacenta a grafului.
# Dictionarul va avea forma:
# {curs : [cursurile care trebuie parcurse inainte]}

numCourses = 4
prerequisites = [[1, 0], [2, 0], [3, 1], [3, 2]]

lista_adiacenta = {}
for curs in range(numCourses):
    lista_adiacenta[curs] = []
for muchii in prerequisites:
    lista_adiacenta[muchii[0]].append(muchii[1])

# Vom construi o functie ce ne va genera pe parcurs raspunsul,
# retinand separat cursurile ce au fost deja parcurse.
# Retinem cursurile parcurse succesiv pentru a gasi un eventual ciclu.

raspuns = []
ciclu = []
cursuri_parcurse = [0 for i in range(numCourses)]


def construire_program_cursuri(curs_curent):
    # Daca ne aflam intr-un ciclu, nu putem stabili ordinea cursurilor.
    if curs_curent in ciclu:
        return False

    # Daca am parcurs deja cursul, trebuie sa trecem la urmatorul curs
    # din lista de adiacenta pentru a continua construirea ordinii.
    if cursuri_parcurse[curs_curent]:
        return True

    # Retinem cursul pentru a gasi un eventual ciclu.
    if curs_curent not in ciclu:
        ciclu.append(curs_curent)

    # Incercam sa mergem "in adancime" prin DFS, ajungand la primul curs
    # care ar trebui urmat, apeland recursiv functia.
    # Daca am gasit si in aceasta parcurgere un ciclu, o oprim.
    for curs_precedent in lista_adiacenta[curs_curent]:
        if not construire_program_cursuri(curs_precedent):
            return False

    # Dupa ce am ajuns la cel mai indepartat curs,
    # il eliminam din eventualul ciclu, il marcam ca fiind
    # parcurs si il adaugam la raspuns.

    ciclu.remove(curs_curent)
    cursuri_parcurse[curs_curent] = 1
    raspuns.append(curs_curent)
    return True


# Incercam sa construim ordinea cursurilor.
# In cazul in care nu se poate realiza acest lucru, returnam lista vida.
# Dupa parcurgere, raspunsul este salvat si putem sa il afisam.

okk = 1
for curs in range(numCourses):
    if not construire_program_cursuri(curs):
        print([])
        okk = 2
        break
if okk != 2:
    print(raspuns)

# Complexitate O(numCourses + len(prerequisites)) deoarece parcurge fiecare nod, mergand
# recursiv pe muchii pentru a stabili ordinea

"""
Varianta incarcata online

class Solution:
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:

        # Folosim un dictionar pentru a face lista de adiacenta a grafului.
        # Dictionarul va avea forma:
        # {curs : [cursurile care trebuie parcurse inainte]}

        lista_adiacenta = {}
        for curs in range(numCourses):
            lista_adiacenta[curs] = []
        for muchii in prerequisites:
            lista_adiacenta[muchii[0]].append(muchii[1])

        # Vom construi o functie ce ne va genera pe parcurs raspunsul,
        # retinand separat cursurile ce au fost deja parcurse.
        # Retinem cursurile parcurse succesiv pentru a gasi un eventual ciclu.

        raspuns = []
        ciclu = []
        cursuri_parcurse = [0 for i in range(numCourses)]

        def construire_program_cursuri(curs_curent):

            # Daca ne aflam intr-un ciclu, nu putem stabili ordinea cursurilor.
            if curs_curent in ciclu:
                return False

            # Daca am parcurs deja cursul, trebuie sa trecem la urmatorul curs
            # din lista de adiacenta pentru a continua construirea ordinii.
            if cursuri_parcurse[curs_curent]:
                return True

            # Retinem cursul pentru a gasi un eventual ciclu.
            if curs_curent not in ciclu:
                ciclu.append(curs_curent)

            # Incercam sa mergem "in adancime" prin DFS, ajungand la primul curs
            # care ar trebui urmat, apeland recursiv functia.
            # Daca am gasit si in aceasta parcurgere un ciclu, o oprim.
            for curs_precedent in lista_adiacenta[curs_curent]:
                if not construire_program_cursuri(curs_precedent):
                    return False

            # Dupa ce am ajuns la cel mai indepartat curs,
            # il eliminam din eventualul ciclu, il marcam ca fiind
            # parcurs si il adaugam la raspuns.

            ciclu.remove(curs_curent)
            cursuri_parcurse[curs_curent] = 1
            raspuns.append(curs_curent)
            return True

        # Incercam sa construim ordinea cursurilor.
        # In cazul in care nu se poate realiza acest lucru, returnam lista vida.
        # Dupa parcurgere, raspunsul este salvat si putem sa il afisam.

        for curs in range(numCourses):
            if not construire_program_cursuri(curs):
                return []
        return raspuns



# --------------------------------------------- SUBPUNCTUL B -------------------------------------------------

# Folosim un dictionar pentru a face lista de adiacenta a grafului.
# Dictionarul va avea forma:
# {curs : [cursurile care trebuie parcurse inainte]}

numCourses = 4
prerequisites = [[1, 0], [2, 1], [3, 2], [1, 3]]

lista_adiacenta = {}
for curs in range(numCourses):
    lista_adiacenta[curs] = []
for muchii in prerequisites:
    lista_adiacenta[muchii[0]].append(muchii[1])

# Vom construi o functie ce ne va genera pe parcurs raspunsul,
# retinand separat cursurile ce au fost deja parcurse.
# Retinem cursurile parcurse succesiv pentru a gasi un eventual ciclu.

raspuns = []
ciclu = []
cursuri_parcurse = [0 for i in range(numCourses)]
raspuns_ciclu = []


def construire_program_cursuri(curs_curent):

    # Daca ne aflam intr-un ciclu, nu putem stabili ordinea cursurilor.
    if curs_curent in ciclu:
        ciclu.append(curs_curent)
        return False

    # Daca am parcurs deja cursul, trebuie sa trecem la urmatorul curs
    # din lista de adiacenta pentru a continua construirea ordinii.
    if cursuri_parcurse[curs_curent]:
        return True

    # Retinem cursul pentru a gasi un eventual ciclu.
    if curs_curent not in ciclu:
        ciclu.append(curs_curent)

    # Incercam sa mergem "in adancime" prin DFS, ajungand la primul curs
    # care ar trebui urmat, apeland recursiv functia.
    # Daca am gasit si in aceasta parcurgere un ciclu, o oprim.
    for curs_precedent in lista_adiacenta[curs_curent]:
        if not construire_program_cursuri(curs_precedent):
            return False

    # Dupa ce am ajuns la cel mai indepartat curs,
    # il eliminam din eventualul ciclu, il marcam ca fiind
    # parcurs si il adaugam la raspuns.

    ciclu.remove(curs_curent)
    cursuri_parcurse[curs_curent] = 1
    raspuns.append(curs_curent)
    return True


# Incercam sa construim ordinea cursurilor.
# In cazul in care nu se poate realiza acest lucru, returnam lista vida.
# Dupa parcurgere, raspunsul este salvat si putem sa il afisam.

ok = 0
for curs in range(numCourses):
    if not construire_program_cursuri(curs):
        print(ciclu)
        ok = 1
        break
if ok == 0:
    print([])

"""
