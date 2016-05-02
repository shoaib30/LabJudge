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
/*
Write a program to find the factorial of a number. where N is the input by the user.

Sample input:
5
Sample Output:
120
*/
