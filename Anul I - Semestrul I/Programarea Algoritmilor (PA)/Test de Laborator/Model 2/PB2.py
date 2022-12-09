def deviruseaza (prop):
    pasi = prop.split()
    pasii = pasi[::-1]
    pasiii = ""
    listacuv = []
    for cuvant in pasii:
        primalitera = cuvant[0]
        ultimalitera = cuvant[len(cuvant)-1]
        cuvant = cuvant.replace(primalitera, ultimalitera, 1)
        cuvantinversat = cuvant[::-1]
        cuvantinversat = cuvantinversat.replace(ultimalitera, primalitera, 1)
        cuvant = cuvantinversat[::-1]
        listacuv.append(cuvant)
    pasiii = " ".join(listacuv)
    return(pasiii)

def prime(n, numar_maxim = 0):
    nrnr = 0
    listanr = []
    for nr in range(2, n):
            ok = 1
            for div in range(2, nr//2+1):
                if (nr % div == 0):
                        ok = 0
            if ok == 1:
                nrnr += 1
                listanr.append(nr)
    if numar_maxim == 0:
        return(listanr)
    else:
        listanr = listanr[:numar_maxim]
        return(listanr)

f = open("intrare.in")
g = open("intrare_devirusata.out", "w")

propozitii = f.readlines()
print(propozitii)
f.close()

randuriprime = prime(len(propozitii)+1)
print(randuriprime)

f = open("intrare.in")
indexu = 1
liniuta = f.readline()
print(liniuta)

while liniuta:
    if indexu in randuriprime:
        g.write(deviruseaza(liniuta))
        g.write("\n")
    else:
        g.write(liniuta)
    indexu += 1
    liniuta = f.readline()

f.close()
g.close()