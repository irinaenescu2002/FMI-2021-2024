def min_max(lista):
    minim = min(lista)
    maxim = max(lista)
    return (minim, maxim)

def incarca_fisier(fisier):
    f = open(fisier)
    lista = []
    citim = f.readlines()
    for listuta in citim:
        listutasplit = list(listuta.split())
        for i in range(len(listutasplit)):
            listutasplit[i] = int(listutasplit[i])
        lista.append(listutasplit)
    f.close()
    return(lista)

f = input()
fisier = open(f)

g = open("egale.txt", "w")
linii = incarca_fisier(f)

ok = 1
listalinii = []
for i in range(len(linii)):
    for j in range(len(linii[i])-1):
        if linii[i][j] != linii[i][j+1]:
            ok = 0
    if ok == 1:
        listalinii.append(i)
    ok = 1

if listalinii != []:
    for numar in listalinii:
        scriem = str(numar)
        g.write(scriem)
        g.write(" ")
else:
    g.write("Nu exista!")

minimax = []
for i in range(len(linii)):
    for j in range(len(linii[i])):
        minimax.append(linii[i][j])
minimsimaxim = min_max(minimax)
print(f"a = {minimsimaxim[0]}")
print(f"b = {minimsimaxim[1]}")