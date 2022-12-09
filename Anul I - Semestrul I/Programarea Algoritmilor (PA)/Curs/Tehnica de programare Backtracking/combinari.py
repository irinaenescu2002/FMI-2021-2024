def bktr(niv):
    global n, k, st
    for val in range(1, n+1):
        st[niv] = val
        if (niv > 1 and st[niv] <= st[niv-1]) is False:
            if niv == k:
                print(*st[1:], sep=", ")
            else:
                bktr(niv+1)

n = int(input("n = "))
k = int(input("k = "))
# o soluție va avea lungimea k
st = [0] * (k+1)
print("Toate submulțimile cu", k, "elemente ale unei mulțimi cu", n, "elemente")
bktr(1)
