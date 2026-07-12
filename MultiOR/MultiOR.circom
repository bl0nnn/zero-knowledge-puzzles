pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that returns true when at least one
// element is 1. It should return false if all elements
// are 0. It should be unsatisfiable if any of the inputs
// are not 0 or not 1.

template MultiOR(n) {
    signal input in[n];
    signal output out;

    in[0] * (1 - in[0]) === 0;
    
    signal sum[n];

    sum[0] <== in[0];
    for (var i = 1; i < n; i++){
        in[i] * (1 - in[i]) === 0;
        sum[i] <== sum[i-1] + in[i];
    }

    component isz = IsZero();

    isz.in <== sum[n-1];

    out <== 1 - isz.out;

}

component main = MultiOR(4);
