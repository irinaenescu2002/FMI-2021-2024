def vocale(*cuvinte):
    vocale = ["a", "e", "i", "o", "u"]
    d = {}
    for cuvant in cuvinte:
        nr = 0
        l = []
        for litera in cuvant:
            if litera in vocale:
                nr += 1
        if nr not in d.keys():
            d[nr] = [cuvant]
        else:
            d[nr].append(cuvant)
    return d

print(vocale("acasa", "masa", "scaun", "oaie", "oare"))

lista_cuvinte = ["acasa", "masa", "este", "scaun"]
lista_rez = [cuv for cuv in lista_cuvinte if cuv[0] == cuv[len(cuv)-1]]
print(lista_rez)
