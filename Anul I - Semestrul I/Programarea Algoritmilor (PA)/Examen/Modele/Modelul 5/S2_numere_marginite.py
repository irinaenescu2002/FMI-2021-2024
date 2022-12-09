def bktr(niv):
    global n, st, i, j
    for val in range(i, j+1):
        st[niv] = val
        if st[niv] not in st[:niv]:
            if niv <= n:
                print(*st[1:niv+1], sep="")
                bktr(niv+1)
            else:
                bktr(niv+1)

i = int(input("i = "))
j = int(input("j = "))
n = j - i + 1
st = [0] * (n+2)
print("Numere marginite:")
bktr(1)
