pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/multiplexer.circom";

// Create a circuit which takes an input 'a',(array of length 2 ) , then  implement power modulo 
// and return it using output 'c'.

// HINT: Non Quadratic constraints are not allowed. (grazie al cock)

template Pow() {
   
   signal input a[2];
   signal output c;

   signal powers[99];

   powers[0] <== 1;
   powers[1] <== a[0];
   for (var i =2; i < 99; i++){
      powers[i] <== a[0]*powers[i-1];
   }

   component mux = Multiplexer(1,99);

   for (var i = 0; i<99; i++){
      mux.inp[i][0] <== powers[i];
   }
   mux.sel <== a[1];

   c <== mux.out[0];
}

component main = Pow();

