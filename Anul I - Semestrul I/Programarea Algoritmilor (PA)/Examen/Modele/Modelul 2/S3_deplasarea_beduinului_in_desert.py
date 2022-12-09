# NU E FINALIZATA

# citim coloana de pe care pleaca beduinul
j_plecare = int(input("De unde pleaca beduinul: "))

# citim inaltimile din matrice
mat = []
while True:
    linie = input()
    if linie:
        linie = [int(x) for x in linie.split()]
        mat.append(linie)
    else:
        break
print(mat)

# cream o copie a matricei de aceeași dimensiune cu matricea mat
n = len(mat)
m = len(mat[0])
copie = [[0]*(m) for i in range(n)]
print(copie)

# copiem ultima linie a matricei
for i in range(m):
    copie[n-1][i] = mat[n-1][i]
print(copie)

# calculăm restul elementelor matricei
for i in range(n-2, -1, -1):
    for j in range(i+1):
        if i+1 < m:
            copie[i][j] = mat[i][j] + min(copie[i + 1][j], copie[i + 1][j + 1])
        elif i + 1 >= m:
            copie[i][j] = mat[i][j] + min(copie[i + 1][j], copie[i + 1][j - 1])
        else:
            copie[i][j] = mat[i][j] + min(copie[i+1][j], copie[i+1][j+1], copie[i+1][j-1])
print(copie)

# afișăm inaltimea minima care se poate obține
hmin = min(copie[0])
print("Inaltimea minima urcata:", hmin)

# verificam daca traseul optim este unic verificand daca putem obtine in mai multe moduri hmin
# adica daca se gaseste de mai multe ori in lista finala
cnt = 0
for elem in copie[0]:
    if elem == hmin:
        cnt += 1
if cnt > 1:
    print("Traseul optim nu este unic")

# afișăm un traseu pe care se poate obține inaltimea minima
print("Traseul cu inaltime minima:")
j = 0
for i in range(n-1):
    print(i, j)
    if copie[i+1][j+1] > copie[i+1][j]:
        j += 1
print(n-1, j)
