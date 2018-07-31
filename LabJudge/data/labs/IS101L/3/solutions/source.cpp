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
