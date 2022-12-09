def citire_matrice(fisier):
    matrice = []
    lung = set()
    with open(fisier, "r") as f:
        for linie in f:
            listaelemente = [int(element) for element in linie.split()]
            matrice.append(listaelemente)
    for linie in matrice:
        lung.add(len(linie))
    if len(lung) > 1:
        return None
    return matrice


def multimi(matrice, *indii):
    rasp_negative = set()
    rasp_cifreegale = set()
    cifreegale = set()
    indici = [int(x) for x in indii]
    for linie in indici:
        negative = set()
        for element in matrice[linie]:
            elemsalv = element
            while elemsalv >= 10:
                elemsalv = elemsalv // 10
            if element < 0:
                negative.add(element)
            if element >= 0 and element % 10 == elemsalv:
                cifreegale.add(element)
            if len(rasp_negative) == 0:
                rasp_negative = negative
            else:
                rasp_negative = rasp_negative.intersection(negative)
            for elem in cifreegale:
                rasp_cifreegale.add(elem)
    return rasp_negative, rasp_cifreegale


mat = citire_matrice("matrice.in")
lmat = int(len(mat))
numere = multimi(mat, lmat-1, lmat-2, lmat-3)[1]
print(*numere)
munere = multimi(mat, lmat-1, 0)[0]
print(len(munere))

