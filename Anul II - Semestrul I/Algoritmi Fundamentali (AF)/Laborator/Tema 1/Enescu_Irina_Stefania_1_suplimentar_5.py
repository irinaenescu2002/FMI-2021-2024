# MAX AREA OF ISLAND

grid = [[0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
        [0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0],
        [0, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0]]

n = len(grid[0])
m = len(grid)
size = max(n, m)

# Am extins matricea pentru a o face patratica in scopul de a lucra mai usor cu lungimile.
# Pentru a extinde matricea am adaugat portiuni cu apa.

if n > m:
    for i in range(n - m):
        grid.append([0 for j in range(n)])
else:
    aux_list = [0 for j in range(m - n)]
    for i in range(m):
        for elem in aux_list:
            grid[i].append(elem)

# Functia plimbare parcurge recursiv tot ce se poate vizita pornind dintr-un punct
# specificat prin coordonatele i j, salvand suprafata parcursa.
# Daca putem inainta pe o portiune de pamant o marcam ca fiind vizitata atribuindu-i
# valoarea 0 - pe apa nu mai putem merge si o adunam la suprafata totala.
# Cele patru conditii if reprezinta cele patru coordonate spre care putem
# merge (N, S, V, E). In cazul in care am dat de apa, ne intoarcem de unde am plecat si incercam
# sa o luam pe alta directie.


def plimbare(i, j):
    s = 0
    if grid[i][j]:
        s += 1
        grid[i][j] = 0
        if i > 0:
            s += plimbare(i-1, j)
        if j < size-1:
            s += plimbare(i, j+1)
        if i < size-1:
            s += plimbare(i+1, j)
        if j > 0:
            s += plimbare(i, j-1)
    return s


# Presupunem ca nu exista o portiune maxima. Pornim dintr-un punct si
# vizitam tot ce se poate vizita din acel punct, calculand pe parcurs
# suprafata vizitata. Daca aceasta este mai mare decat cea calculata anterior,
# o actualizam astfel incat la final sa avem salvat maximul.

a = 0
smax = 0
for i in range(size):
    for j in range(size):
        if grid[i][j]:
            a = plimbare(i, j)
            if a > smax:
                smax = a

print(smax)


"""

Varianta incarcata online

class Solution(object):
    def maxAreaOfIsland(self, grid):
        n = len(grid[0])
        m = len(grid)
        size = max(n, m)

        # Am extins matricea pentru a o face patratica in scopul de a lucra mai usor cu lungimile.
        # Pentru a extinde matricea am adaugat portiuni cu apa.

        if n > m:
            for i in range(n - m):
                grid.append([0 for j in range(n)])
        else:
            aux_list = [0 for j in range(m - n)]
            for i in range(m):
                for elem in aux_list:
                    grid[i].append(elem)

        # Functia plimbare parcurge recursiv tot ce se poate vizita pornind dintr-un punct
        # specificat prin coordonatele i j, salvand suprafata parcursa.
        # Daca putem inainta pe o portiune de pamant o marcam ca fiind vizitata atribuindu-i
        # valoarea 0 - pe apa nu mai putem merge si o adunam la suprafata totala.
        # Cele patru conditii if reprezinta cele patru coordonate spre care putem
        # merge (N, S, V, E). In cazul in care am dat de apa, ne intoarcem de unde am plecat si incercam
        # sa o luam pe alta directie.


        def plimbare(i, j):
            s = 0
            if grid[i][j]:
                s += 1
                grid[i][j] = 0
                if i > 0:
                    s += plimbare(i-1, j)
                if j < size-1:
                    s += plimbare(i, j+1)
                if i < size-1:
                    s += plimbare(i+1, j)
                if j > 0:
                    s += plimbare(i, j-1)
            return s


        # Presupunem ca nu exista o portiune maxima. Pornim dintr-un punct si
        # vizitam tot ce se poate vizita din acel punct, calculand pe parcurs
        # suprafata vizitata. Daca aceasta este mai mare decat cea calculata anterior,
        # o actualizam astfel incat la final sa avem salvat maximul.

        a = 0
        smax = 0
        for i in range(size):
            for j in range(size):
                if grid[i][j]:
                    a = plimbare(i, j)
                    if a > smax:
                        smax = a

        return smax

Complexitate: O(max(n, m)^2)

"""