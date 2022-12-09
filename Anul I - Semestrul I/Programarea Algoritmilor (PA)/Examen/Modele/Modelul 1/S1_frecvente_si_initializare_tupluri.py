def frecvente(*liste):
    d = {}
    multime = set()
    for lista in liste:
        multime.update(lista)
    for elem in multime:
        aparitii = 0
        for lista in liste:
            aparitii += lista.count(elem)
        if aparitii not in d.keys():
            d[aparitii] = []
            d[aparitii].append(elem)
        else:
            d[aparitii].append(elem)
    return d

print(frecvente([20, 10, 40], [10, 20, 10], [40, 30, 40]))

tupluri = [(x, x//6, x % 6) for x in range(1, 21) if x % 6 != x//6]
print(tupluri)
