def bktr(niv):
    global n, st
    for val in range(1, n+1):
        st[niv] = val
        if (niv > 1 and st[niv] <= st[niv-1]) is False:
            print(*st[1:niv+1], sep=", ")
            bktr(niv+1)

n = int(input("n = "))
# o soluție va avea lungimea k
st = [0] * (n+2)
print("Toate submulțimile unei mulțimi cu", n, "elemente")
bktr(1)

