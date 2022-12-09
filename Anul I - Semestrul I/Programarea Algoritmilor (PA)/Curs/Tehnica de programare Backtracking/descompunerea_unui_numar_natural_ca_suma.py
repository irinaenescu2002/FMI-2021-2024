def bktr(niv):
    global st, n
    for val in range(1, n-niv+2):
        st[niv] = val
        sumacrt = sum(st[:niv+1])
        if sumacrt <= n:
            if sumacrt == n:
                print(*st[1:niv+1], sep=" + ")
            else:
                bktr(niv+1)

n = int(input("n = "))
st = [0] * (n+1)
bktr(1)
