#include<iostream>
using namespace std;
int main()
{
    int n;
    cin>>n;
    for(int i=1;i<=n;i++)
    {
        for(int j=n-i;j>0;j--)
            cout<<" ";
        for(int k=1;k<=i;k++)
            cout<<"* ";

        cout<<endl;
    }
    for(int i=n-1;i>0;i--)
    {
        for(int j=n-i;j>0;j--)
            cout<<" ";
        for(int k=1;k<=i;k++)
            cout<<"* ";

        cout<<endl;
    }
}
/*

print a pattern similar to

         *
        * *
       * * *
      * * * *
     * * * * *
    * * * * * *
   * * * * * * *
  * * * * * * * *
 * * * * * * * * *
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

