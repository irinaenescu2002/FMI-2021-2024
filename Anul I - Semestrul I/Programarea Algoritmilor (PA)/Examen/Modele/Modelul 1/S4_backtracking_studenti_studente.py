def bktr(niv):
    global nrf, nrb, fete, baieti, st, maxim
    if niv <= maxim:
        for fata in fete:
            st[niv] = fata
            if fata not in st[1:niv] and st[niv] >= st[niv-1] and niv <= s:
                if niv == s:
                    print(*st[1:niv+1], sep=", ")
                else:
                    bktr(niv+1)
    else:
        for baiat in baieti:
            st[niv] = baiat
            if baiat not in st[1:niv] and st[niv] >= st[niv-1] and niv <= s:
                if niv == s:
                    print(*st[1:niv+1], sep=", ")
                else:
                    bktr(niv+1)


nrf = int(input("NRF = "))
nrb = int(input("NRB = "))
s = int(input("S = "))

fete = [int(x) for x in range(1, nrf+1)]
baieti = [int(x) for x in range(nrf+1, nrf+nrb+1)]

st = [0]*(s+1)
if s % 2 == 1:
    print("Nu se poate forma nici o grupa cu proprietatile cerute.")
else:
    maxim = s//2
    bktr(1)
