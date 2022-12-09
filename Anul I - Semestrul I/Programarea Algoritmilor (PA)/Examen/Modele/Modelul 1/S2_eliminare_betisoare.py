# functie folosita pentru sortarea crescătoare a betisoarelor
# în raport de capatul final
def sfarsit(b):
    return b[1]

# citim numarul betisoarelor
nr = int(input("Cate betisoare avem: "))

# citim capetele lor si le salvam intr-o lista de tupluri
bet = []
nrcrt = 1
for i in range(nr):
    aux = [int(x) for x in input("Betisor: ").split()]
    bet.append((nrcrt, aux[0], aux[1]))
    nrcrt += 1

# sortăm betisoarele în ordinea crescătoare a sfârșitului
bet.sort(key=sfarsit)

# aranj = o listă care conține o aranjare optima a betisoarelor,
# inițializată cu primul betisor
aranj = [bet[0]]
# parcurgem restul betisoarelor
for bat in bet[1:]:
    # dacă betisorul curent începe după ultimul betisor
    # pus, atunci îl punem și pe el
    if bat[1] >= aranj[len(aranj)-1][2]:
        aranj.append(bat)

be = []
for bat in bet:
    if bat not in aranj:
        be.append(bat[0])
be.sort()
print(*be)
