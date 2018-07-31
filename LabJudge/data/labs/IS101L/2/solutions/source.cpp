#include<iostream>
using namespace std;

int main()  {
    int x;
    cin>>x;
    int fact=1;
    for(int i=x; i>=1; i--)
        fact*=i;
    cout<<fact;
}
