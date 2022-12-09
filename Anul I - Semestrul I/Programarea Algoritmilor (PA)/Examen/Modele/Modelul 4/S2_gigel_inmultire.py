cartonase = [int(x) for x in input("Valori scrise pe cartonase: ").split()]
n = len(cartonase)

cartonase.sort()
cartneg = []
cartpoz = []
cf = []
produs = 1

for cart in cartonase:
    if cart < 0:
        cartneg.append(cart)

cartneg.sort()
if len(cartneg) % 2 == 0:
    for i in range(0, len(cartneg), 2):
        produs = produs*cartneg[i]*cartneg[i+1]
        cf.append(cartneg[i])
        cf.append(cartneg[i+1])
else:
    for i in range(0, len(cartneg)-1, 2):
        produs = produs * cartneg[i] * cartneg[i + 1]
        cf.append(cartneg[i])
        cf.append(cartneg[i + 1])

for cart in cartonase:
    if cart > 0:
        cartpoz.append(cart)

cartpoz.sort(reverse=True)
if len(cartpoz) % 2 == 0:
    for i in range(0, len(cartpoz), 2):
        produs = produs * cartpoz[i] * cartpoz[i + 1]
        cf.append(cartpoz[i])
        cf.append(cartpoz[i + 1])
else:
    for i in range(0, len(cartpoz) - 1, 2):
        produs = produs * cartpoz[i] * cartpoz[i + 1]
        cf.append(cartpoz[i])
        cf.append(cartpoz[i + 1])

print("Cartonase folosite:")
print(*cf)
print(produs)
