
#include <bits/stdc++.h>

/* * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *  [ Algoritmo de Bernstein-Vazirani Clássico ]       *  
 *  Complexidade de O(n), necessitando a utilizagem    *
 *  de "n" portas AND para saber qual o valor secreto. *                             
 * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* C++11 */

using namespace std;
using ll = long long;
using lu = long unsigned;

ll bitLength(ll number) {
  
    if (number == 0) return 1; 
    return std::floor( std::log2(number) ) + 1;
    
}

int main() {

  ll secret_number = 727;
  ll i = 1;
  std::vector< int > existance;
		       
  for ( int j = 0; j < bitLength(secret_number) ; j ++ ) {
    
    ll current_and = i & secret_number;
    existance.push_back( current_and );
    i *= 2;
    
  }

  ll result = 0;
  
  for ( auto i : existance )
    result += i;

  cout << "The found secret number is : " << result;

  return EXIT_SUCCESS;
    
}

