def note(*liste):
    d = {}
    for lista in liste:
        cnt = 0
        for nota in lista:
            if nota >= 5:
                cnt += 1
        if cnt not in d.keys():
            d[cnt] = []
            d[cnt].append(lista)
        else:
            d[cnt].append(lista)
    return d

print(note([5, 4, 2, 7, 10], [6, 7, 8, 10, 3], [10, 7, 4, 10, 9], [5, 6, 8, 4, 1], [5, 5, 6, 10, 7, 9]))

lista_cuvinte = ["acasa", "masa", "este", "scaun", "perete", "dulap"]
lista_sufixe = ["sa", "te"]
lista_rez = [cuv for cuv in lista_cuvinte if cuv[(len(cuv)-2):(len(cuv))] in lista_sufixe]
print(lista_rez)

