def bktr(niv):
    global st, n, cuv, cuvinte
    for val in range(1, n+1):
        st[niv] = val
        if st[niv] not in st[1:niv]:
            if niv == n:
                aux = "".join([cuv[st[i]-1] for i in range(1, n+1)])
                cuvinte.add(aux)
            else:
                bktr(niv+1)

cuv = input("cuv = ")
n = len(cuv)
cuvinte = set()
# o soluție s va avea n elemente
st = [0]*(n+1)
bktr(1)
print("Anagramele distincte ale cuvantului " + cuv + ":")
print(*cuvinte, sep="\n")
