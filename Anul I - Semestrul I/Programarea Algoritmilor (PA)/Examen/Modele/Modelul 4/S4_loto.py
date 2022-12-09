# PROBLEMA NEFINALIZATA - nu verifica paritatea

# def paritate(niv):
#     ok = 0
#     for i in range(len(st)):
#         for j in range(i, len(st)):
#             if st[i] % 2 != st[j] % 2:
#                 ok = 1
#     return ok

def bktr(niv):
    global n, k, st
    for val in range(1, n+1):
        st[niv] = val
        if ((niv > 1 and st[niv] <= st[niv-1]) is False) and ((niv > 1 and st[niv] == st[niv-1] + 1) is False):
            if niv == k:
                print(*st[1:], sep=", ")
            else:
                bktr(niv+1)

n = int(input("n = "))
k = 6
st = [0] * (k+1)
bktr(1)
