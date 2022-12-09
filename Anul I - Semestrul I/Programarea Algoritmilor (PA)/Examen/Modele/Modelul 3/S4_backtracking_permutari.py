def bktr(niv):
    global st, n                                        # st reprezinta stiva in care urcam valorile pentru a le verifica
    for val in range(1, n+1):                           # pentru fiecare valoare de la 1 la n
        st[niv] = val                                   # urcam valoarea in stiva
        if st[niv] not in st[:niv]:                     # daca nu a mai fost urcata pana atunci, deci, daca e corecta
            if niv == n:                                # daca am ajuns sa generam o permutare
                print(*st[1:], sep=", ")                # o afisam
            else:
                 bktr(niv+1)                            # altfel urcam un nivel pentru a genera in continuare

n = int(input("n = "))
st = [0]*(n+1)                                          # solutia va avea n elemente, deci initializam stiva cu n+1 zerouri
print("Toate permutările de lungime " + str(n) + ":")
bktr(1)                                                 #apelam functia de la primul nivel
