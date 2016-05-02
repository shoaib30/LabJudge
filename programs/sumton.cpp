#include<iostream>
using namespace std;

int main()  {
    int x;
    cin>>x;
    int sum=0;
    for(int i= 1; i<=x; i++)
        sum+=i;
    cout<<sum<<endl;
    return 0;
}
/*
Write a program to find the sum upto N, where N is the input by the user

Sample Input:
10
Sample Output:
55
*/
