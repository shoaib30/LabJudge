#include<iostream>
using namespace std;
int main()
{
    int n;
    cin>>n;
    for(int i=n;i>0;i--)
    {
        for(int j=n-i;j>0;j--)
            cout<<" ";
        for(int k=i;k>0;k--)
            cout<<"* ";
        cout<<endl;
    }
}
/*

print a pattern similar to

* * * * * * * * * *
 * * * * * * * * *
  * * * * * * * *
   * * * * * * *
    * * * * * *
     * * * * *
      * * * *
       * * *
        * *
         *


*/
