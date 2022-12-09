def cautare_binara(t, x, st, dr):
    if st > dr:
        return (f"Elementul {x} nu se afla in lista.")

    mij = (st+dr) // 2
    if x == t[mij]:
        return (f"Elementul {x} se afla in lista.")
    elif x < t[mij]:
        return cautare_binara(t, x, st, mij-1)
    else:
        return cautare_binara(t, x, mij+1, dr)

lista = [int(x) for x in input("Elementele listei: ").split()]
element = int(input("Elementul cautat: "))
lista.sort()

print(cautare_binara(lista, element, 0, len(lista)-1))