def cifra_control(n):
    suma = 0
    if n <= 9:
        return(n)
    else:
        while n != 0:
            cifra = n % 10
            suma = suma + cifra
            n = n // 10
        if (suma >= 10):
            suma = cifra_control(suma)
    return (suma)


def insereaza_cifra_control (lista):
    for i in range(2 * len(lista)):
        if i % 2 == 0:
            cfr = cifra_control(lista[i])
            lista.insert(i+1, cfr)


def egale(*liste):
    for lista in liste:
        if len(liste[0]) != len(lista):
            return False
        else:
            for i in range(len(lista)):
                if liste[0][i] != lista[i]:
                    return False
    return True


f = open("numere.in")
g = open("numere2.in")

numere = [int(x) for x in f.read().split()]
insereaza_cifra_control(numere)

for i in range(0, len(numere), 2):
    print(numere[i], numere[i+1], sep = " ")

f.close()
f = open("numere.in")

numeref = [int(x) for x in f.read().split()]
numereg = [int(x) for x in g.read().split()]

numeref.sort()
numereg.sort()

numerefu = []
for nr in numeref:
    if nr not in numerefu:
        numerefu.append(nr)

numeregu = []
for nr in numereg:
    if nr not in numeregu:
        numeregu.append(nr)

insereaza_cifra_control(numerefu)
insereaza_cifra_control(numeregu)

ccf = []
ccg = []

for i in range(1, len(numerefu), 2):
    ccf.append(numerefu[i])
for i in range(1, len(numeregu), 2):
    ccg.append(numerefu[i])

if egale(ccf, ccg):
    print("Da")
else:
    print("Nu")

f.close()
g.close()