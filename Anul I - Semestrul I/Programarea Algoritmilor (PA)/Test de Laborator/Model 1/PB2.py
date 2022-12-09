def modifica_prefix (x, y, prop):
    modificari = 0
    propsplit = prop.split()
    for cuv in propsplit:
        if cuv.startswith(x) == 1:
         modificari += 1
         cuvvechi = cuv
         cuv = cuv.replace(x, y)
         prop = prop.replace(cuvvechi, cuv)
    return(prop, modificari)

def poz_max (lista):
    maxim = max(lista)
    maxime = []
    for i in range(len(lista)):
        if lista[i] == maxim:
            maxime.append(i)
    return (maxime)

cuvinte = input()
cuvinte = cuvinte.split()
a = cuvinte[0]
b = cuvinte[1]

modificarimax = []
f = open("propozitii.in")
g = open("propozitii_modificate.out", "w")
for prop in f:
    functie = modifica_prefix(a, b, prop)
    modificarimax.append(functie[1])
    g.write(functie[0])

f.close()
g.close()

pozitii = poz_max(modificarimax)
for pozitie in pozitii:
    print(pozitie+1, end=" ")