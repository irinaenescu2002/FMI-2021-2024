# TUTORIAT 11 (MODEL EXAMEN)
# subiectul 1
# a)

# multimea_vida = set(), dar nu multimea_vida = { } este dictionar

# def litere(*cuvinte):
#     dict_words = {}
#     for cuv in cuvinte:
#         dict_words[cuv] = {}
#         for litera in cuv:
#             if litera not in dict_words[cuv].keys():
#                 dict_words[cuv][litera] = 1
#             else:
#                 dict_words[cuv][litera] += 1
#     return dict_words
#
#
# print(litere("teste", "programare"))

# b)
# numere = [x for x in range(10, 100) if x % 2 == 0 and x % 6 != 0]
# print(numere)

# model examen(Greedy)

# m = int(input("m= "))
# n = int(input("n= "))
# A = []
# B = []
# for i in range(m):
#     A.append(int(input("elem=")))
# for i in range(n):
#     B.append(int(input("elem=")))
# A.sort(reverse=True)
# B.sort(reverse=True)
# s_max = 0
# index_A = 0
# while A[index_A] > 0:
#       s_max += A[index_A]*B[index_A]
#       index_A += 1
#
# # index_B = len(B) -1
# index_B = -1
# # for i in range(index_B, index_A, -1):
# for i in range(-1, -index_A, -1):
#     s_max += A[i] * B[i]
#
# print(s_max)



