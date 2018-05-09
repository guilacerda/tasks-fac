#include <bits/stdc++.h>

using namespace std;

int main (){

  int a, b, c;
  int count = 0;
  cin >> a;

  b = a;

  while(b != c){
    c = b;
    b = (b/2) + (a/b)/2;
    cout << b << endl;
    count++;
  }

  cout << a << " " << b << " " << c << " " << count << endl;

  return 0;
}
