def bktr(niv):
    global st, P, monede, n
    # s[k] = numarul de monede cu valoarea v[k] utilizate
    for val in range(0, P // monede[niv] + 1):
        st[niv] = val
        scrt = sum([st[i] * monede[i] for i in range(niv+1)])
        if scrt <= P:
            if scrt == P and niv == n:
                for i in range(1, n+1):
                    if st[i] != 0:
                        print(st[i], "x", monede[i], "$ + ", end="")
                print()
            else:
                if niv < len(monede[1:]):
                    bktr(niv+1)

P = int(input("Suma de plată: "))
aux = [int(x) for x in input("Valorile monedelor: ").split()]
monede = [0]
monede.extend(aux)
n = len(monede[1:])
st = [0]*(len(monede))
print("Toate modalitățile de plată:")
bktr(1)
