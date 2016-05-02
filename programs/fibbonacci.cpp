#include<iostream>
using namespace std;

int main()  {
    int a=0;
    int b=1;
    int x;
    int c;
    cin>>x;
    cout<<a<<endl;
    cout<<b<<endl;
    while(x>=2) {
        c=a+b;
        cout<<c<<endl;
        a=b;
        b=c;
        x--;
    }
}
/*
Write a program to print the fibonnaci series upto N, where N is the input by the user.

Sample input:
5
Sample Output:
0
1
1
2
3
*/
