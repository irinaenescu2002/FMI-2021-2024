def bktr(niv):
    global st, n, t, cnt
    for val in range(1, st[niv-1]+1 if niv != 1 else t+1):
        st[niv] = val
        sumacrt = sum(st[:niv+1])
        if sumacrt <= n:
            if sumacrt == n:
                print(*st[1:niv+1], sep=" + ")
                cnt += 1
            else:
                bktr(niv+1)

n = int(input("n = "))
t = int(input("t = "))
st = [0] * (n+1)
cnt = 0
bktr(1)
print(f"Asadar, exista {cnt} modalitati in care Laika poate urca treptele.")
