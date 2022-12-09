# m = numarul cartonaselor ce trebuie imperecheate
A = [int(x) for x in input("A = ").split()]
m = len(A)

# n = numarul cartonaselor disponibile
B = [int(x) for x in input("B = ").split()]
n = len(B)

# sortam listele crescator pentru a inmulti fie cele mai mari numere negative intre ele,
# fie un numar negativ cu cel mai mic numar natural
# astfel o sa avem fie cel mai mare numar natural obtinut din inmultirea a doua numere negative,
# fie cel mai mic numar negativ obtinut din inmultirea unui numar negativ cu unul natural
A.sort()
B.sort()

# suma reprezinta suma totala, iar contorul contorizeaza cate numere negative am avut
suma = 0
cnt = 0

# pentru fiecare numar din lista A, daca este negativ il inmultim cu corespondentul din lista B
# acesta se afla pe aceeasi pozitie (ne-am asigurat de asta prin sortare)
for i in range(m):
    if A[i] < 0:
        cnt += 1
        suma += A[i]*B[i]
        if B[i] < 0:
            print(f"({A[i]})*({B[i]}) + ", end="")
        else:
            print(f"({A[i]})*{B[i]} +", end=" ")

# sortam listele descrescator pentru a inmulti fie cele mai mari numere naturale intre ele,
# fie un numar natural cu cel mai mic numar negativ
# astfel o sa avem fie cel mai mare numar natural obtinut din inmultirea a doua numere naturale,
# fie cel mai mic numar negativ obtinut din inmultirea unui numar negativ cu unul natural
A.sort(reverse=True)
B.sort(reverse=True)

# pentru fiecare numar din lista A, daca este natural il inmultim cu corespondentul din lista B
# acesta se afla pe aceeasi pozitie (ne-am asigurat de asta prin sortare)
# daca nu este ultimul element il afisam normal, dar daca este afisam cu un = la final
for i in range(m):
    if A[i] > 0:
        suma += A[i]*B[i]
        if i < m - cnt - 1:
            print(f"{A[i]}*{B[i]} + ", end="")
        else:
            print(f"{A[i]}*{B[i]} = ", end="")

#afisam si suma la final
print(suma)

