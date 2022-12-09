t = [int(x) for x in input("t = ").split()]                     # t este sirul total
n = len(t)                                                      # n este lungimea sirului

lmax = [1] * n                                                  # lmax[i] marcheaza lungimea maxima a unui subsir crescator care se termina cu t[i]
pred = [-1] * n                                                 # pred[i] retine indicele predecesorului unui element
lmax[0] = 1

for i in range(1, n):                                           # pentru fiecare numar t[i]
    for j in range(0, i):                                       # pentru toate numerele dinaintea numarului t[i]
        if t[j] <= t[i] and lmax[i] < 1 + lmax[j]:              # daca am gasit un numar mai mare si il putem alipi la un sir mai mare
            pred[i] = j                                         # salvam pozitia elementului
            lmax[i] = 1 + lmax[j]                               # actualizam lungimea

pmax = 0
for i in range(1, n):
    if lmax[i] > lmax[pmax]:
        pmax = i                                                # cauta si salveaza lungimea maxima

print("Lungimea maxima a unui subsir crescator:", lmax[pmax])
print("Un subsir crescator maximal:")
i = pmax
sol = []
while i != -1:
    sol.append(t[i])
    i = pred[i]
print(*sol[::-1])
