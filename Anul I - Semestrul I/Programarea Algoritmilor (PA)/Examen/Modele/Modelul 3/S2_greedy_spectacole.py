# functie folosita pentru sortarea crescătoare a spectacolelor
# în raport de ora de sfârșit (cheia)
def cheieOraSfârșit(sp):
    return sp[2]

n = int(input("n = "))
lsp = []
for i in range(1, n+1):
    nume = "Spectacol " + str(i)
    print(nume)
    orai = input("Ora inceput = ").strip()
    oraf = input("Ora sfarsit = ").strip()
    tuplu = (nume, orai, oraf)
    lsp.append(tuplu)

print(lsp)
# lsp = lista spectacolelor, fiecare spectacol fiind memorat
# sub forma unui tuplu (ID, ora de început, ora de sfârșit)

# sortăm spectacolele în ordinea crescătoare a timpilor de sfârșit
lsp.sort(key=cheieOraSfârșit)
print(lsp)
# posp = o listă care conține o programare optima a spectacolelor,
# inițializată cu primul spectacol
posp = [lsp[0]]
# parcurgem restul spectacolelor
for sp in lsp[1:]:
    # dacă spectacolul curent începe după ultimul spectacol
    # programat, atunci îl programăm și pe el
    if sp[1] >= posp[len(posp)-1][2]:
        posp.append(sp)

# scriem datele de ieșire în fișierul text "programare.txt"
print("Numarul maxim de spectacole: "+str(len(posp)))
print("Spectacolele programate:")
for sp in posp:
    print(sp[1] + "-" + sp[2] + " " + str(sp[0]))

