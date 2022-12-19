# PUNCTE DE CONTROL

f = open("graf.in")
g = open("graf.out", 'w')

nm = [int(x) for x in f.readline().split()]
n = nm[0]
m = nm[1]


# Am citit graful si l-am salvat cu ajutorul unui dictionar, unei liste de adiacenta:
# nod : [vecinii nodului]
lista_adiacenta = {}
for i in range(1, n+1):
    lista_adiacenta[i] = []
for i in range(m):
    xy = [int(x) for x in f.readline().split()]
    x = xy[0]
    y = xy[1]
    lista_adiacenta[x].append(y)
    lista_adiacenta[y].append(x)


# Am citit si salvat punctele de control intr-o lista.
puncte_control = [int(x) for x in f.readline().split()]


# Am implementat o functie pe principiul BFS. Am construit parcurgerea
# pe nivele, astel incat indexul nivelului sa imi dea distanta minima de la nodul curent
# la cel mai apropiat punct de control.
# Pentru fiecare nod din ultimul nivel parcurs am trecut mai departe la vecinii sai in cazul in care
# acestia nu fusesera deja vizitati. In momentul in care am vizitat toate nodurile, daca un punct
# de control se afla pe acel nivel, indexul nivelului reprezenta practic distanta minima.


def parcurgere(liste_bfs):
    nivel_nou = []
    for nod in liste_bfs[-1]:
        for nod_vecin in lista_adiacenta[nod]:
            if verificat[nod_vecin] == 0:
                nivel_nou.append(nod_vecin)
                verificat[nod_vecin] = 1
    liste_bfs.append(nivel_nou)
    if sum(verificat) == n:
        for nivel_punct in liste_bfs:
            for punct in puncte_control:
                if punct in nivel_punct:
                    distanta_minima = str(liste_bfs.index(nivel_punct))
                    g.write(distanta_minima)
                    g.write(' ')
                    return
    else:
        parcurgere(liste_bfs)


# Pentru fiecare nod am reinitializat vectorul ce verifica parcurgerea fiecarui nod, afisand in functie
# distanta minima.
for i in range(n):
    verificat = [0 for x in range(1, n + 2)]
    parcurgere([[i+1]])

# Complexitate O(n+m)
