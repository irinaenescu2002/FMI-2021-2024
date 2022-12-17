import random
import time
import sys
sys.setrecursionlimit(10000000)
import math

# PYTHON SORT
def python_sort(v):
    v.sort()
    print("✓", end=" ")


# COUNTING SORT
def counting_sort(v):
    element_maxim = max(v)
    contor = [0] * (element_maxim+1)
    vector_sortat = [0] * len(v)
    for i in range(len(v)):
        contor[v[i]] += 1
    for i in range(1, len(contor)):
        contor[i] = contor[i-1] + contor[i]
    i = len(v)-1
    while i >= 0:
        vector_sortat[contor[v[i]]-1] = v[i]
        contor[v[i]] -= 1
        i -= 1
    print("✓", end=" ")


# COUNTING SORT 10 - Algoritm inclus in RADIX SORT 10
def counting_sort_radix_10(v, putere):
    contor = [0] * 10
    vector_sortat = [0] * len(v)
    for i in range(len(v)):
        element = v[i] // putere
        contor[element % 10] += 1
    for i in range(1, len(contor)):
        contor[i] = contor[i-1] + contor[i]
    i = len(v)-1
    while i >= 0:
        element = v[i] // putere
        vector_sortat[contor[element % 10]-1] = v[i]
        contor[element % 10] -= 1
        i -= 1


# RADIX SORT 10
def radix_sort_10(v):
    element_max = max(v)
    putere = 1
    while(element_max // putere > 0):
        counting_sort_radix_10(v, putere)
        putere = putere * 10
    print("✓", end=" ")


# COUNTING SORT 2^16 - Algoritm inclus in RADIX SORT 10
def counting_sort_radix_216(v, putere):
    contor = [0] * (2 ^ 16)
    vector_sortat = [0] * len(v)
    for i in range(len(v)):
        element = v[i] // putere
        contor[element % (2 ^ 16)] += 1
    for i in range(1, len(contor)):
        contor[i] = contor[i-1] + contor[i]
    i = len(v)-1
    while i >= 0:
        element = v[i] // putere
        vector_sortat[contor[element % (2 ^ 16)]-1] = v[i]
        contor[element % (2 ^ 16)] -= 1
        i -= 1


# RADIX SORT 2^16
def radix_sort_216(v):
    element_max = max(v)
    putere = 1
    while(element_max // putere > 0):
        counting_sort_radix_2(v, putere)
        putere = putere * (2 ^ 16)
    print("✓", end=" ")


# COUNTING SORT 2^8 - Algoritm inclus in RADIX SORT 10
def counting_sort_radix_28(v, putere):
    contor = [0] * (2 ^ 8)
    vector_sortat = [0] * len(v)
    for i in range(len(v)):
        element = v[i] // putere
        contor[element % (2 ^ 8)] += 1
    for i in range(1, len(contor)):
        contor[i] = contor[i-1] + contor[i]
    i = len(v)-1
    while i >= 0:
        element = v[i] // putere
        vector_sortat[contor[element % (2 ^ 8)]-1] = v[i]
        contor[element % (2 ^ 8)] -= 1
        i -= 1


# RADIX SORT 2^8
def radix_sort_28(v):
    element_max = max(v)
    putere = 1
    while(element_max // putere > 0):
        counting_sort_radix_28(v, putere)
        putere = putere * (2 ^ 8)
    print("✓", end=" ")


# COUNTING SORT 2 - Algoritm inclus in RADIX SORT 10
def counting_sort_radix_2(v, putere):
    contor = [0] * 2
    vector_sortat = [0] * len(v)
    for i in range(len(v)):
        element = v[i] // putere
        contor[element % 2] += 1
    for i in range(1, len(contor)):
        contor[i] = contor[i-1] + contor[i]
    i = len(v)-1
    while i >= 0:
        element = v[i] // putere
        vector_sortat[contor[element % 2]-1] = v[i]
        contor[element % 2] -= 1
        i -= 1


# RADIX SORT 2
def radix_sort_2(v):
    element_max = max(v)
    putere = 1
    while(element_max // putere > 0):
        counting_sort_radix_2(v, putere)
        putere = putere * 2
    print("✓", end=" ")


# SHELL SORT 2
def shell_sort2(v, n):
    interval = n // 2
    while interval > 0:
        for i in range(interval, n):
            aux = v[i]
            j = 1
            while j >= interval and v[j-interval] > aux:
                v[j] = v[j-interval]
                j = j - interval
            v[j] = aux
        interval = interval // 2
    print("✓", end=" ")


# SHELL SORT 10
def shell_sort10(v, n):
    interval = n // 10
    while interval > 0:
        for i in range(interval, n):
            aux = v[i]
            j = 1
            while j >= interval and v[j-interval] > aux:
                v[j] = v[j-interval]
                j = j - interval
            v[j] = aux
        interval = interval // 10
    print("✓", end=" ")


# MERGE SORT
def merge_sort(v):
    if len(v) > 1:
        mijloc = len(v) // 2
        stanga = v[:mijloc]
        dreapta = v[mijloc:]
    else:
        return
    merge_sort(stanga)
    merge_sort(dreapta)
    st = 0
    dr = 0
    poz = 0
    while st < len(stanga) and dr < len(dreapta):
        if stanga[st] < dreapta[dr]:
            v[poz] = stanga[st]
            st = st + 1
        else:
            v[poz] = dreapta[dr]
            dr = dr + 1
        poz = poz + 1
    while st < len(stanga):
        v[poz] = stanga[st]
        st = st + 1
        poz = poz + 1

    while dr < len(dreapta):
        v[i] = dreapta[dr]
        dr = dr + 1
        poz = poz + 1


# QUICK SORT - Ultimul element
def impartire_vector_u(v, stanga, dreapta):
    pivot = v[dreapta]
    i = stanga - 1
    for j in range(stanga, dreapta):
        if v[j] <= pivot:
            i = i + 1
            aux = v[i]
            v[i] = v[j]
            v[j] = aux
    auxx = v[i+1]
    v[i+1] = v[dreapta]
    v[dreapta] = auxx
    return i + 1

def quick_sort_u(v, stanga, dreapta):
    if stanga < dreapta:
        poz = impartire_vector_u(v, dreapta, stanga)
        quick_sort_u(v, stanga, poz-1)
        quick_sort_u(v, poz+1, dreapta)



# QUICK SORT - Mediana din 3
def mediana(v, stanga, dreapta):
    mijloc = (stanga+dreapta-1)//2
    x = v[stanga]
    y = v[mijloc]
    z = v[dreapta-1]
    return sorted((x, y, z))[1]

def impartire_vector_med(v, stanga, dreapta):
    pivot = mediana(v, stanga, dreapta)
    i = stanga - 1
    for j in range(stanga, dreapta):
        if v[j] <= pivot:
            i = i + 1
            aux = v[i]
            v[i] = v[j]
            v[j] = aux
    auxx = v[i+1]
    v[i+1] = v[dreapta]
    v[dreapta] = auxx
    return i + 1

def quick_sort_med(v, stanga, dreapta):
    if stanga < dreapta:
        poz = impartire_vector_med(v, dreapta, stanga)
        quick_sort_med(v, stanga, poz-1)
        quick_sort_med(v, poz+1, dreapta)


# Fisierul "teste.txt" contine:
# - pe primul rand T (numarul de teste)
# - pe urmatoarele T randuri o pereche de numere:
# (N - numarul de elemente care trebuie sortate,
# numerele fiind generate automat si
# Max - cel mai mare numar care poate fi generat)

# Citim numarul de teste separat.
# Formam o lista cu testele, aceasta
# continand tupluri de forma (N, Max).


f = open("teste.txt")
nr_teste = int(f.readline())
teste = []
linie = f.readline()
while linie != "":
    t = linie.split()
    n = int(t[0])
    mx = int(t[1])
    teste.append((n, mx))
    linie = f.readline()
print()

for test in teste:
    i = 1
    v = []
    n = test[0]
    nt = test[0]
    mx = test[1]
    while nt != 0:
        v.append(random.randrange(0, mx))
        nt -= 1

    print("Numarul de elemente =", end=" ")
    print(n)
    print("Valoarea maxima a unui element =", end=" ")
    print(mx)
    aux = v

    start = time.time()
    python_sort(v)
    end = time.time()
    print("PYTHON SORT               ", end=" ")
    print(round(end - start, 6), end=" ")
    print("s")
    v = aux

    start = time.time()
    counting_sort(v)
    end = time.time()
    print("COUNTING SORT             ", end=" ")
    print(round(end - start, 6), end=" ")
    print("s")
    v = aux

    start = time.time()
    radix_sort_10(v)
    end = time.time()
    print("RADIX SORT (baza 10)      ", end=" ")
    print(round(end - start, 6), end=" ")
    print("s")
    v = aux

    start = time.time()
    radix_sort_2(v)
    end = time.time()
    print("RADIX SORT (baza 2)       ", end=" ")
    print(round(end - start, 6), end=" ")
    print("s")
    v = aux

    start = time.time()
    radix_sort_28(v)
    end = time.time()
    print("RADIX SORT (baza 2^8)     ", end=" ")
    print(round(end - start, 6), end=" ")
    print("s")
    v = aux

    start = time.time()
    radix_sort_216(v)
    end = time.time()
    print("RADIX SORT (baza 2^16)    ", end=" ")
    print(round(end - start, 6), end=" ")
    print("s")
    v = aux

    start = time.time()
    shell_sort2(v, n)
    end = time.time()
    print("SHELL SORT (2)            ", end=" ")
    print(round(end - start, 6), end=" ")
    print("s")
    v = aux

    start = time.time()
    shell_sort10(v, n)
    end = time.time()
    print("SHELL SORT (10)           ", end=" ")
    print(round(end - start, 6), end=" ")
    print("s")
    v = aux

    # start = time.time()
    # quick_sort_u(v, 0, n-1)
    # end = time.time()
    # print("✓", end=" ")
    # print("QUICK SORT (U)            ", end=" ")
    # print(round(end - start, 6), end=" ")
    # print("s")
    # v = aux


    # start = time.time()
    # quick_sort_med(v, 0, n - 1)
    # end = time.time()
    # print("✓", end=" ")
    # print("QUICK SORT (MED)          ", end=" ")
    # print(round(end - start, 6), end=" ")
    # print("s")
    # v = aux

    start = time.time()
    merge_sort(v)
    end = time.time()
    print("✓", end=" ")
    print("MERGE SORT                ", end=" ")
    print(round(end - start, 6), end=" ")
    print("s")
    v = aux

    print("===================================================")
    print()

