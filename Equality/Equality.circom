pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";

// Input 3 values using 'a'(array of length 3) and check if they all are equal.
// Return using signal 'c'.

template Equality() {
   signal input a[3];
   signal output c;

   component Eq1 = IsEqual();
   component Eq2 = IsEqual();

   Eq1.in[0] <== a[0];
   Eq1.in[1] <== a[1];

   Eq2.in[0] <== a[1];
   Eq2.in[1] <== a[2];

   c <== Eq1.out * Eq2.out;
   c === 1;
}

component main = Equality();