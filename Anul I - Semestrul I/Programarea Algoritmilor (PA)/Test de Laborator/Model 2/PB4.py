def despre_spiridus(date, codspiridus):
    lista = []
    for juc in date[codspiridus].items():
        lista.append(juc)
    lista.sort(key=lambda inreg: (-inreg[1], inreg[0]))
    return lista


def jucarii(date):
    multime = set()
    for spiridus in date.keys():
        multime.update(date[spiridus].keys())
    return multime


def spiridusi(date):
    lista = []
    for spiridus in date.keys():
        cantitate = 0
        jucariidif = 0
        for jucarie in date[spiridus].keys():
            cantitate += date[spiridus][jucarie]
            jucariidif += 1
        lista.append((spiridus, jucariidif, cantitate))
    lista.sort(key=lambda x: (-x[1], -x[2], x[0]))
    return lista


f = open("spiridus.in")
date = {}
datecitite = f.readlines()
for linie in datecitite:
    liniesplit = linie.strip().split()
    cod = liniesplit[0]
    cantitate = int(liniesplit[1])
    jucarie = liniesplit[2]
    if (cod in date.keys()) is False:
        date[cod] = {jucarie: cantitate}
    elif (jucarie in date[cod].keys()) is False:
        date[cod].update({jucarie: cantitate})
    else:
        date[cod][jucarie] += cantitate


def actualizare(date, codspiridus, numejucarie):
    if date[codspiridus][numejucarie] >= 2:
        del date[codspiridus][numejucarie]
        return True
    return False


print(date)
print(despre_spiridus(date, "S1"))
print(*jucarii(date), sep=", ")
for listuta in spiridusi(date):
    print(listuta)
actualizare(date, "S1", "trenulet")
print(despre_spiridus(date, "S1"))