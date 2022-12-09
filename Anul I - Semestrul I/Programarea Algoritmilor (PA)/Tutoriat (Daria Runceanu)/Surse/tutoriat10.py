# TUTORIAT 10 - RECAPITULARE TEST LABORATOR

# EX.1
# a) VARIANTA 1
# def modifica_litera(p, x, y, prop):
#     words = prop.split()
#     words_number = len(words)
#     words_modified = 0
#     prop_modified = ""
#     for word in words:
#         word_modified = word
#         if len(word) >= p and word[p-1] == x:
#             word_modified = word[:p-1] + y + word[p:]
#             words_modified += 1
#         prop_modified = prop_modified + word_modified + ' '
#     return prop_modified, words_number - words_modified


# varianta 2


# def modifica_litera2(p, x, y, prop):
#     words = prop.split()
#     words_modified = 0
#     for i in range(len(words)):
#         if len(words[i]) >= p and words[i][p-1] == x:
#             words[i] = words[i][:p-1] + y + words[i][p:]
#             words_modified += 1
#     prop_modified = " ".join(words)
#     return prop_modified, len(words) - words_modified


# p = 2
# x = 'n'
# y = 'm'
# prop = "ana ane mere ane"
# print(modifica_litera2(p, x, y, prop))
# prop_m, number = modifica_litera(p, x, y, prop)


# ls = ["ama", "ame", "mere", "ame"]
# prop1 = " ".join(ls)
# print(prop1)

# b)
# def poz_x(ls, x):
#     pozitii = []
#     for i in range(len(ls)):
#         if ls[i] == x:
#             pozitii.append(i + 1)
#     return pozitii
#
# ls = [7, 5, 9, 10, 25, 18, 75, 5, 5, 1]
# res = poz_x(ls, 5)
# print(res)

# c)
# f = open("propozitii.in", 'r')  # 'r' implicit
# g = open("propozitii_modificate.out", 'w')
#
# p, x, y = input("Valorile date: ").split()
# p = int(p)

# inp = input("Valorile date: ").split()
# p, x, y = int(inp[0]), inp[1], inp[2]
# index = []
# for line in f:
#     new_line = line.rstrip("\n")
#     prop_modif, numar = modifica_litera2(p, x, y, new_line)
#     g.write(prop_modif + "\n")
#     if new_line != "":
#         index.append(len(new_line.split()) - numar)
#
# poz_unmodified = poz_x(index, 0)
# print(poz_unmodified)
#
# f.close()
# g.close()

# EX.2
# dictionar de dictionare
# a)
data = {}

def read_data():
    f = open("spiridusi.txt")
    lines = f.readlines()
    for line in lines:
        line_splited = line.strip().split()
        cod_spiridus, numar_bucati, jucarii = line_splited
        if (cod_spiridus in data.keys()) is False:
            data[cod_spiridus] = {jucarii: int(numar_bucati)}
        elif (jucarii in data[cod_spiridus].keys()) is False:
            data[cod_spiridus][jucarii] = int(numar_bucati)
        else:
            data[cod_spiridus][jucarii] += int(numar_bucati)
    f.close()

read_data()
print(data)
# b)
def despre_spiridus(data, cod):
    return [value for value in data[cod].items()]


# c)
def jucarii(data):
    sol = set()

    for item in data.values():
        for itemKey in item.keys():
            sol.add(itemKey)
    # sol = {x for x in data.values()}
    return list(sol)


# d)
def sorting_func(a, b):
    if a[1] > b[1]:
        return -5
    if a[1] == b[1] and a[2] > b[2]:
        return -3
    if a[2] == b[2] and a[0] > b[0]:
        return -2


def spiridusi(data):
    sol = []
    for key, value in data.items():
        name = key
        distinct_products = len(value)
        total_products = 0
        for item in value.values():
            total_products += item

        sol.append((name, distinct_products, total_products))

    return sorted(sol, key=lambda x: (-x[1], -x[2], x[0]))


# e)
def actualizare(data, spiridus_name, toy_name):
    if len(data[spiridus_name].values()) >= 2:
        del data[spiridus_name][toy_name]
        return True

    return False



actualizare(data, "S1", "trenulet")
print(despre_spiridus(data, "S1"))













