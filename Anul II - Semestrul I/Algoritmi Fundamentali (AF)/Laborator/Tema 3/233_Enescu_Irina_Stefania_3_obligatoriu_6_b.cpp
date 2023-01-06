#include <iostream>

using namespace std;

/// Complexitate: O(len(str1)*len(str2))

class Solution {
public:
    string shortestCommonSupersequence(string str1, string str2) {

        /// Lungimea minima a supersecventei va fi egala cu:
        /// L = (len(str1) + len(str2)) - LCS
        /// unde LCS = lungimea subsecventei comune celor doua siruri

        /// Pe aceasta am calculat-o la problema anterioara:

        int s1 = str1.length();
        int s2 = str2.length();
        int mat[s1+1][s2+1];

        for(int i=0; i<=s1; i++)
           for (int j=0; j<=s2; j++)
               mat[i][j] = 0;

        for (int i=0; i<s1+1; i++)
            for (int j=0; j<s2+1; j++)
                if (i == 0 || j == 0) ;
                else if (str1[i-1] == str2[j-1]) mat[i][j] = 1 + mat[i-1][j-1];
                else mat[i][j] = max(mat[i-1][j], mat[i][j-1]);

        int lcs = mat[s1][s2];

        int minLenSuperseq = s1 + s2 - lcs;

        /// Pentru a gasi si subsecventa (ne trebuie pentru a forma supersecventa),
        /// in loc de lungime punem direct sirul format.

        string matString[s1+1][s2+1];

        for(int i=0; i<=s1; i++)
           for (int j=0; j<=s2; j++)
               matString[i][j] = "";

        for (int i=0; i<s1+1; i++)
            for (int j=0; j<s2+1; j++)
                if (i == 0 || j == 0) ;
                else if (str1[i-1] == str2[j-1]) matString[i][j] = matString[i-1][j-1] + str1[i-1];
                else if (mat[i-1][j] > mat[i][j-1]) matString[i][j] = matString[i-1][j];
                else matString[i][j] = matString[i][j-1];

        string lcsString = matString[s1][s2];

        /// Vom construi supersecventa maxima ajutandu-ne de subsecventa dupa cum urmeaza:
        /// Pentru fiecare litera din subsecventa:
        /// ---> punem litere din primul sir pana cand ajungem la litera curenta din subsecventa
        /// ---> punem litere din al doilea sir pana cand ajungem la litera curenta din subsecventa
        /// ---> punem litera din subsecventa O SINGURA DATA
        /// La final, adaugam literele din siruri care au ramas.

        string superSeq = "";
        int i = 0, j = 0;

        for (int s=0; s<lcsString.length(); s++)
        {
            while (str1[i] != lcsString[s])
            {
                superSeq += str1[i];
                i++;
            }

            while (str2[j] != lcsString[s])
            {
                superSeq += str2[j];
                j++;
            }

            superSeq += lcsString[s];
            i++;
            j++;
        }

        for (int p=i; p<s1; p++)
            superSeq += str1[p];
        for (int p=j; p<s2; p++)
            superSeq += str2[p];

        return superSeq;
    }
};

int main()
{
    cout << "Hello world!" << endl;
    return 0;
}
