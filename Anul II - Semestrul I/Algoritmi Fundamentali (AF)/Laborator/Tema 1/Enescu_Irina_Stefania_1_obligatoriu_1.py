# POSSIBLE BIPARTITION

# --------------------------------------------- SUBPUNCTUL A -------------------------------------------------

n = 10
dislikes = [[4, 7], [4, 8], [5, 6], [1, 6], [3, 7], [2, 5], [5, 8], [1, 2],
            [4, 9], [6, 10], [8, 10], [3, 6], [2, 10], [9, 10], [3, 9], [2, 3],
            [1, 9], [4, 6], [5, 7], [3, 8], [1, 8], [1, 7], [2, 4]]

# Problema se rezuma la a verifica daca un graf este bipartit, nodurile grafului
# reprezentand persoanele din grup si muchiile grafului reprezentand faptul ca
# persoana x nu se intelege cu persoana y.

# Formam un dictionar pentru a retine pentru fiecare persoana persoanele
# cu care nu se intelege.

group = {}
for i in range(1, n+1):
    group[i] = []
for elem in dislikes:
    group[elem[0]].append(elem[1])

# Folosim o lista in care sa marcam in ce grup trimitem fiecare persoana si
# o lista pentru a retine persoanele deja plasate intr-un grup.
# Pornim separarea persoanelor de la prima persoana.

bipartition = [0 for i in range(n+1)]
bipartition[1] = 1
vertices = [1]

# Cat timp mai avem de distribuit persoane, ne uitam la fiecare persoana la persoanele
# cu care nu ar trebui sa fie in grup. Daca o persoana nu ar trebui sa fie in acelasi grup cu alta si
# nu a fost deja repartizata, o repartizam in celalalt grup. In cazul in care a fost deja repartizata
# in aceeasi echipa, acest lucru inseamna ca nu se pot forma doua grupuri, ci mai multe.
# Daca au fost repartizate toate persoanele si nu au existat conflicte, acest lucru inseamna
# ca putem forma doua grupuri.
# In cazul in care o persoana nu are nici o pretentie, trecem la urmatoarea persoana pentru
# a continua repartizarea, asigurandu-ne ca nu o punem intr-un grup in care se gaseste
# o persoana ce nu se intelege cu ea.


def f():
    while len(vertices) != 0:
        current = vertices[-1]
        vertices.remove(vertices[-1])
        for vertex in range(1, n+1):
            if vertex in group[current] and bipartition[vertex] == 0:
                if bipartition[current] == 1:
                    bipartition[vertex] = 2
                elif bipartition[current] == 2:
                    bipartition[vertex] = 1
                vertices.append(vertex)
            else:
                if vertex in group[current] and bipartition[vertex] == bipartition[current]:
                    return False
        if not group[current] and len(vertices) == 0:
            save = 0
            ok = 0
            p = 0
            for vert in range(1, n+1):
                if bipartition[vert] == 0:
                    ok = 1
                    save = vert
                    break
            if len(vertices) == 0 and ok == 1:
                vertices.append(save)
            for j in range(1, n+1):
                if save in group[j]:
                    p = bipartition[save]
                    break
            if p == 1:
                bipartition[save] = 2
            else:
                bipartition[save] = 1
    return True


print(f())


"""
Varianta incarcata online

class Solution(object):
    def possibleBipartition(self, n, dislikes):

        # Problema se rezuma la a verifica daca un graf este bipartit, nodurile grafului
        # reprezentand persoanele din grup si muchiile grafului reprezentand faptul ca
        # persoana x nu se intelege cu persoana y.

        # Formam un dictionar pentru a retine pentru fiecare persoana persoanele
        # cu care nu se intelege.

        group = {}
        for i in range(1, n+1):
            group[i] = []
        for elem in dislikes:
            group[elem[0]].append(elem[1])

        # Folosim o lista in care sa marcam in ce grup trimitem fiecare persoana si
        # o lista pentru a retine persoanele deja plasate intr-un grup.
        # Pornim separarea persoanelor de la prima persoana.

        bipartition = [0 for i in range(n+1)]
        bipartition[1] = 1
        vertices = [1]

        # Cat timp mai avem de distribuit persoane, ne uitam la fiecare persoana la persoanele
        # cu care nu ar trebui sa fie in grup. Daca o persoana nu ar trebui sa fie 
        # in acelasi grup cu alta si nu a fost deja repartizata,
        #  o repartizam in celalalt grup. In cazul in care a fost deja repartizata
        # in aceeasi echipa, acest lucru inseamna ca nu se pot forma doua grupuri, ci mai multe.
        # Daca au fost repartizate toate persoanele si nu au existat conflicte,
        #  acest lucru inseamna ca putem forma doua grupuri.
        # In cazul in care o persoana nu are nici o pretentie, trecem la urmatoarea persoana 
        # pentru a continua repartizarea.


        while len(vertices) != 0:
            current = vertices[-1]
            vertices.remove(vertices[-1])
            for vertex in range(1, n+1):
                if vertex in group[current] and bipartition[vertex] == 0:
                    if bipartition[current] == 1:
                        bipartition[vertex] = 2
                    elif bipartition[current] == 2:
                        bipartition[vertex] = 1
                    vertices.append(vertex)
                else:
                    if vertex in group[current] and bipartition[vertex] == bipartition[current]:
                        return False
            if group[current] == [] and len(vertices) == 0:
                save = 0
                ok = 0
                p = 0
                for vert in range(1, n+1):
                    if bipartition[vert] == 0:
                        ok = 1
                        save = vert
                        break
                if len(vertices) == 0 and ok == 1:
                    vertices.append(save)
                for j in range(1, n+1):
                    if save in group[j]:
                        p = bipartition[save]
                        break
                if p == 1:
                    bipartition[save] = 2
                else:
                    bipartition[save] = 1
        return True



# --------------------------------------------- SUBPUNCTUL B -------------------------------------------------


n = 10
dislikes = [[4, 7], [4, 8], [5, 6], [1, 6], [3, 7], [2, 5], [5, 8], [1, 2],
            [4, 9], [6, 10], [8, 10], [3, 6], [2, 10], [9, 10], [3, 9], [2, 3],
            [1, 9], [4, 6], [5, 7], [3, 8], [1, 8], [1, 7], [2, 4]]

# Problema se rezuma la a verifica daca un graf este bipartit, nodurile grafului
# reprezentand persoanele din grup si muchiile grafului reprezentand faptul ca
# persoana x nu se intelege cu persoana y.

# Formam un dictionar pentru a retine pentru fiecare persoana persoanele
# cu care nu se intelege.

group = {}
for i in range(1, n+1):
    group[i] = []
for elem in dislikes:
    group[elem[0]].append(elem[1])

# Folosim o lista in care sa marcam in ce grup trimitem fiecare persoana si
# o lista pentru a retine persoanele deja plasate intr-un grup.
# Pornim separarea persoanelor de la prima persoana.

bipartition = [0 for i in range(n+1)]
bipartition[1] = 1
vertices = [1]

# Cat timp mai avem de distribuit persoane, ne uitam la fiecare persoana la persoanele
# cu care nu ar trebui sa fie in grup. Daca o persoana nu ar trebui sa fie in acelasi grup cu alta si
# nu a fost deja repartizata, o repartizam in celalalt grup. In cazul in care a fost deja repartizata
# in aceeasi echipa, acest lucru inseamna ca nu se pot forma doua grupuri, ci mai multe.
# Daca au fost repartizate toate persoanele si nu au existat conflicte, acest lucru inseamna
# ca putem forma doua grupuri.
# In cazul in care o persoana nu are nici o pretentie, trecem la urmatoarea persoana pentru
# a continua repartizarea, asigurandu-ne ca nu o punem intr-un grup in care se gaseste
# o persoana ce nu se intelege cu ea.


def f():
    while len(vertices) != 0:
        current = vertices[-1]
        vertices.remove(vertices[-1])
        for vertex in range(1, n+1):
            if vertex in group[current] and bipartition[vertex] == 0:
                if bipartition[current] == 1:
                    bipartition[vertex] = 2
                elif bipartition[current] == 2:
                    bipartition[vertex] = 1
                vertices.append(vertex)
            else:
                if vertex in group[current] and bipartition[vertex] == bipartition[current]:
                    return False
        if not group[current] and len(vertices) == 0:
            save = 0
            ok = 0
            p = 0
            for vert in range(1, n+1):
                if bipartition[vert] == 0:
                    ok = 1
                    save = vert
                    break
            if len(vertices) == 0 and ok == 1:
                vertices.append(save)
            for j in range(1, n+1):
                if save in group[j]:
                    p = bipartition[save]
                    break
            if p == 1:
                bipartition[save] = 2
            else:
                bipartition[save] = 1
    return True


d = f()
first = []
second = []
if d:
    for i in range(1, n+1):
        if bipartition[i] == 1:
            first.append(i)
        else:
            second.append(i)

print("First group: ", first)
print("Second group: ", second)

Complexitate: O(n+m)
"""
