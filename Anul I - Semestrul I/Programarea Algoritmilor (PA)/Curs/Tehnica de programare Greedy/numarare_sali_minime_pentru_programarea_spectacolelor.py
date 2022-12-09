import queue

# functie folosita pentru sortarea crescătoare a spectacolelor
# în raport de ora de început (cheia)
def cheieOraÎnceput(sp):
    return sp[1]

# citim datele de intrare din fișierul text "sali_spectacole.txt"
fin = open("sali_spectacole.txt")
# lsp = lista spectacolelor, fiecare spectacol fiind memorat
# sub forma unui tuplu (ID, ora de început, ora de sfârșit)
lsp = []
crt = 1
for linie in fin:
    aux = linie.split("-")
    # aux[0] = ora de început a spectacolului curent
    # aux[1] = ora de sfârșit a spectacolului curent
    lsp.append((crt, aux[0].strip(), aux[1].strip()))
    crt = crt + 1
fin.close()

# sortăm spectacolele crescător după orelor de început
lsp.sort(key=cheieOraÎnceput)

# sălile vor fi stocate într-o coadă cu priorități în care
# prioritatea unei săli este dată de ora de terminare a
# ultimului spectacol planificat în sala respectivă, iar
# spectacolele planificate în ea vor fi păstrate într-o listă
sali = queue.PriorityQueue()

# planificăm primul spectacol în prima sală
sali.put((lsp[0][2], list((lsp[0],))))

# parcurgem restul spectacolelor
for k in range(1, len(lsp)):
    # extragem sala cu ora minimă de terminare a ultimului
    # spectacol planificat în ea
    min_timp_final = sali.get()

    # dacă spectacolul curent lsp[k] poate fi planificat în
    # sala extrasă, atunci îl adăugăm în lista spectacolelor
    # planificate în ea și reintroducem sala în coada cu
    # priorități, dar cu prioritatea actualizată la ora de
    # terminare a spectacolului adăugat
    if lsp[k][1] >= min_timp_final[0]:
        min_timp_final[1].append(lsp[k])
        sali.put((lsp[k][2], min_timp_final[1]))
# dacă spectacolul curent lsp[k] nu poate fi planificat în
# sala extrasă, atunci reintroducem sala extrasă în coada
# cu priorități fără a-i modifica prioritatea și adăugăm
# o sală nouă în care planificăm spectacolul curent
    else:
        sali.put(min_timp_final)
        sali.put((lsp[k][2], list((lsp[k],))))

# scriem datele de ieșire în fișierul text "programare.txt"
fout = open("sali_programare.txt", "w")
fout.write("Numar minim de sali: " + str(sali.qsize()) + "\n")

scrt = 1
while not sali.empty():
    sala = sali.get()
    fout.write("\nSala " + str(scrt) + ":\n")
    for sp in sala[1]:
        fout.write("\t"+sp[1]+"-"+sp[2]+" Spectacol "+ str(sp[0]) + "\n")
    scrt += 1
fout.close()