# CHECK DFS

# In rezolvarea problemei am utilizat algoritmul clasic DFS implementat la laborator.
# Singura modificare care trebuia adusa in constructia parcurgerii consta in
# ordonarea vecinilor fiecarui nod in functie de ordinea in care apareau in
# parcurgerea ceruta. Acest lucru l-am modificat usor sortand valorile din lista de adiacenta
# a fiecarui nod cu ajutorul unei functii.
# Complexitate: O(n+m)

import sys
sys.setrecursionlimit(100001)

nm = [int(x) for x in input().split()]
n = nm[0]
m = nm[1]

order = [int(x) for x in input().split()]
check_order = [0 for i in range(n+1)]
for i in range(n):
    check_order[order[i]] = i


def sort_function(x):
    return check_order[x]


graph = {}
for i in range(1, n+1):
    graph[i] = []
for i in range(m):
    xy = [int(x) for x in input().split()]
    graph[xy[0]].append(xy[1])
    graph[xy[1]].append(xy[0])
for key in graph.keys():
    graph[key].sort(key=sort_function)

check = [0 for i in range(n+1)]
dfs_list = []


def dfs(current):
    check[current] = 1
    dfs_list.append(current)
    for x in graph[current]:
        if check[x] == 0:
            dfs(x)
    return


dfs(1)
if dfs_list == order:
    print(1)
else:
    print(0)
