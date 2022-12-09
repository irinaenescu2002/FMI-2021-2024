def divizori (*numere):
    d = {}
    for elem in numere:
        if elem not in d.keys():
            d[elem] = []
            for div in range(2, elem + 1):
                if elem % div == 0:
                    ok = 1
                    for divdiv in range(2, div):
                        if div % divdiv == 0:
                            ok = 0
                            break
                    if ok == 1:
                        d[elem].append(div)
    return d

print(divizori(50, 21))

litere_10 = [chr(i) for i in range(ord('a'), ord('a')+10)]
print(litere_10)
