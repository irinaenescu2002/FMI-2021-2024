#include <iostream>

using namespace std;

class Test
{
    int x;
    int *v;
public:
    Test()
    {
        x = 123;
        v = NULL;
    }
    ~Test()
    {
        x = -789;
        delete[] v;
        v = NULL;
    }
    friend istream& operator>>(istream& in, Test& ob)
    {
        in>>ob.x;
        ob.v = new int[3];
        for(int i = 0; i<3; i++)
            in>>ob.v[i];
        return in;
    }
    friend ostream& operator<<(ostream& out, const Test& ob)
    {
        out<<ob.x<<" ";
        if (ob.v == NULL) out<<"NULL\n";
        else out<<ob.v[0]<<" "<<ob.v[1]<<" "<<ob.v[2]<<"\n";
        return out;
    }
/// copy
    Test(Test& ob)
    {
        cout<<"\nCopy constructor  ";
        x = ob.x;
        v = new int[3];
        for(int i = 0; i<3; i++) v[i] = ob.v[i];
    }
    Test& operator= (Test& ob)
    {
        if (this != &ob)
        {
            cout<<"\nCopy asignment  ";
            x = ob.x;
            v = new int[3];
            for(int i = 0; i<3; i++) v[i] = ob.v[i];
        }
        return *this;
    }

};

const Test g()
{
    Test z;
    cin>>z;
    return z;
}

int main()
{
    Test A;
    cin>>A;
    Test B(A);
    cout<<B;
    Test C;
    C = B;
    cout<<C;

    cout<<g();

    return 0;
}
