n = 7
sir = "casa apa bun bine fila dop orar"
lista = [s for s in sir.split()]
pred = [[-1]]*n
lung = [1]*n
for i in range(0, n):
    for j in range(0, i):
        x = lista[i][0]
        y = lista[j][len(lista[j])-1]
        if abs(ord(x)-ord(y)) == 1 and lung[j]+1 >= lung[i]:
            if lung[i] < lung[j]+1:
                lung[i] = lung[j]+1
                pred[i] = [j]
            else:
                pred[i].append(j)

maxim = max(lung)
poz = lung.index(maxim)
sol = [lista[poz]]
ok = 0
i = pred[poz][0]
k = maxim-1
while k > 0:
    if len(pred[i]) > 1:
        ok = 1
    sol.append(lista[i])
    i = pred[i][0]
    k -= 1

print(sol)
for cuv in lista:
    if cuv not in sol:
        print(cuv, end=" ")
if ok == 1 or lung.count(maxim) > 1:
	print("\nsolutia nu este unica")
else:
    print("\nsolutie unica")