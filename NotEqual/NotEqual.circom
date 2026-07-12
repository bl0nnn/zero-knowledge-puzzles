pragma circom 2.1.4;

include "../node_modules/circomlib/circuits/comparators.circom";


// Input : a , length of 2 .
// Output : c .
// In this exercise , you have to check that a[0] is NOT equal to a[1], if not equal, output 1, else output 0.
// You are free to use any operator you may like . 

// HINT:NEGATION

template NotEqual() {

    signal input a[2];
    signal output c;

    //constrain a values to avoid modular arithmetic wrapping over BN254 modulus
    component n2b = Num2Bits(252); 
    n2b.in <== a[0];

    component n2b2 = Num2Bits(252);
    n2b2.in <== a[1];

    component ieq = IsEqual();

    ieq.in[0] <== a[0];
    ieq.in[1] <== a[1];

    c <== 1 - ieq.out;
   
}

component main = NotEqual();