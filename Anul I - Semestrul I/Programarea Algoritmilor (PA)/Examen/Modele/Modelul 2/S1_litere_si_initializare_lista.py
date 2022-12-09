def litere(*cuvinte):
    d = {}
    for cuv in cuvinte:
        d[cuv] = {}
        for litera in cuv:
            if litera not in d[cuv].keys():
                d[cuv][litera] = 1
            else:
                d[cuv][litera] += 1
    return d

print(litere("teste", "programare"))

numere = [int(x) for x in range(10, 100) if (x % 2 == 0 and x % 6 != 0) == True]
print(numere)
