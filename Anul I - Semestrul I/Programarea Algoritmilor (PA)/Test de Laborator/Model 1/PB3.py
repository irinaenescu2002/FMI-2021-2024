def sterge_carte(dict, cod):
    if cod in dict.keys():
        salvaut = dict[dict[cod][0]]
        del dict[cod]
        return salvaut
    else:
        return None

def carti_autor(dict, cod):
    informatii = []
    if cod in dict.keys():
        numeautor = dict[cod]
        for carte in dict.values():
            if cod == carte[0]:
                informatii.append((carte[3], carte[1], carte[2]))
        informatii.sort(key=lambda x: (x[1], -x[2], x[0]))
        return numeautor, informatii
    return informatii


d = {}
f = open("autori.in")
date = f.readline().split()
m = int(date[0])
n = int(date[1])
for i in range(m):
    autor = f.readline().split()
    cod = int(autor[0])
    nume = autor[1]
    prenume = autor[2]
    d[cod] = nume + " " + prenume
for i in range(m, m+n):
    carte = f.readline().split()
    autorc = int(carte[0])
    codc = int(carte[1])
    an = int(carte[2])
    pag = int(carte[3])
    numec = []
    for j in range(4, len(carte)):
        numec.append(carte[j])
    numecc = " ".join(numec)
    d[codc] = (autorc, an, pag, numecc)

print(d)

codcitit = int(input("Introduceti codul cartii: "))

fcta = carti_autor(d, codcitit)
if len(fcta) == 0:
    print("cod incorect")
else:
    print(fcta[0])
    for i in fcta[1]:
        print(*i)

# fct = sterge_carte(d, codcitit)
# if fct == None:
#     print("Cartea nu exista.")
# else:
#     print(f"Cartea a fost scrisa de {fct}.")
# print(d)
