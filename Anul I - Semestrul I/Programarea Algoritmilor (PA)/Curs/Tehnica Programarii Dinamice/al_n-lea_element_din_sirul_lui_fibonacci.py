def fib(n):
    f = [-1, 0, 1]
    for i in range(3, n+1):
        f.append(f[i-2] + f[i-1])
    return f[n]

poz = int(input("Pozitie: "))
print(fib(poz))
