def bktr(niv):
    global st, n, k
    for val in range(1, n+1):
        st[niv] = val
        if st[niv] not in st[:niv]:
            if niv == k:
                print(*st[1:], sep=", ")
            else:
                 bktr(niv+1)

n = int(input("n = "))
k = int(input("k = "))
# o soluție s va avea k elemente
st = [0]*(k+1)
print(f"Toate aranjamentele de n = {n} luate cate k = {k} sunt:")
bktr(1)
