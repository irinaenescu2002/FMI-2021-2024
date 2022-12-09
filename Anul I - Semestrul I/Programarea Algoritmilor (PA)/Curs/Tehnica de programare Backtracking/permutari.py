def bktr(niv):
    global st, n
    for val in range(1, n+1):
        st[niv] = val
        if st[niv] not in st[:niv]:
            if niv == n:
                print(*st[1:], sep=", ")
            else:
                 bktr(niv+1)

n = int(input("n = "))
# o soluție s va avea n elemente
st = [0]*(n+1)
print("Toate permutările de lungime " + str(n) + ":")
bktr(1)
