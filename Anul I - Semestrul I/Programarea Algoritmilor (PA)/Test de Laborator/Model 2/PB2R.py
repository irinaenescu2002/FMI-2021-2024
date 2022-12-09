def deviruseaza(prop):
    v = []
    propBuna = ""
    for cuv in prop.split():
        if len(cuv) > 1:
            mid = cuv[1: len(cuv) - 1]
            cuvNou = cuv[len(cuv) - 1] + mid + cuv[0]
            v.append(cuvNou)
        else:
            v.append(cuv)
    for cuv in v.__reversed__():
        propBuna += cuv + " "
    return propBuna


def prime(n, numar_maxim = 0):
    cnt = 0
    raspuns = []
    for nr in range(2, n):
        for i in range(2, int(nr / 2) + 1):
            if nr % i == 0:
                break
        else:
            cnt += 1
            raspuns.append(nr)
        if numar_maxim != 0 and cnt == numar_maxim:
            break
    return raspuns


f = open("input2.in", "r")
g = open("intrare_devirusatar.out", "w")

linii_prime = prime(len(f.readlines()) + 1)
cnt = 1

liniee = f.readline()
print(liniee)
while liniee:
    if cnt in linii_prime:
        g.write(deviruseaza(liniee))
        g.write("\n")
    else:
        g.write(liniee)

    cnt += 1
    liniee = f.readline()
