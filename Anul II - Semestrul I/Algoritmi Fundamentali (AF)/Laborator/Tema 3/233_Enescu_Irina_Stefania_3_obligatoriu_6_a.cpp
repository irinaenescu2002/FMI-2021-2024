#include <iostream>

using namespace std;

/// Complexitate O(len(text1)*len(text2))

class Solution {
public:
    int longestCommonSubsequence(string text1, string text2) {

        int t1 = text1.length();
        int t2 = text2.length();
        int mat[t1+1][t2+1];

        /// Am folosit o matrice de tipul:

        ///     a c e
        ///   0 0 0 0
        /// a 0 0 0 0
        /// b 0 0 0 0
        /// c 0 0 0 0
        /// d 0 0 0 0
        /// e 0 0 0 0

        /// Aceasta este initializata cu 0 pe marginea de sus si pe marginea
        /// din stanga pentru a ne ajuta la a calcula maximul lungimilor conform
        /// lungimilor calculate anterior (ne folosim de mat[i-1]). Pe restul patratelelor o sa suprascriem 0-ul
        /// cu valoarea calculata la fiecare pas.

        for(int i=0; i<=t1; i++)
            for (int j=0; j<=t2; j++)
                mat[i][j] = 0;

        /// Calculam fiecare patratica din matrice mat[i][j] ca fiind cea mai mare
        /// subsecventa comuna a sirului text1 de la 0 la i si a sirului text2 de la 0 la j.
        /// --> daca suntem pe linia si coloana cu 0-uri nu facem nimic
        /// --> daca literele sunt egale, incrementam cu 1 lungimea de pe diagonala in stanga sus
        ///     (acolo avem lungimea maxima gasita pana atunci, respectand ordinea)
        /// --> daca nu sunt egale, punem maximul gasit pana atunci = max(elementele de
        ///     pe coloana de deasupra casutei curente, elementele de pe linia din stanga casutei curente)

        for (int i=0; i<t1+1; i++)
            for (int j=0; j<t2+1; j++)
                if (i == 0 || j == 0) ;
                else if (text1[i-1] == text2[j-1]) mat[i][j] = 1 + mat[i-1][j-1];
                else mat[i][j] = max(mat[i-1][j], mat[i][j-1]);

        /// In final, matricea va arata asa:

        ///     a c e
        ///   0 0 0 0
        /// a 0 1 1 1
        /// b 0 1 1 1
        /// c 0 1 2 2
        /// d 0 1 2 2
        /// e 0 1 2 3

        /// Ultima casuta (dreapta jos) va reprezenta lungimea maxima.

        return mat[t1][t2];

    }
};

int main()
{
    cout << "Hello world!" << endl;
    return 0;
}
