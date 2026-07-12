pragma circom 2.1.8;

include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that takes an array of signals `in[n]` and
// a signal k. The circuit should return 1 if `k` is in the list
// and 0 otherwise. This circuit should work for an arbitrary
// length of `in`.

template HasAtLeastOne(n) {
    signal input in[n];
    signal input k;
    signal output out;

    signal bools[n];

    component ieq[n];
    for (var i = 0; i < n; i++){
        ieq[i] = IsEqual();
        ieq[i].in[0] <== in[i];
        ieq[i].in[1] <== k;

        ieq[i].out ==> bools[i]; 
    }

    var acc = 0;
    for (var i = 0; i < n; i++){
        acc += bools[i];
    }

    component isz = IsZero();

    isz.in <== acc;

    out <== 1 - isz.out;

}

component main = HasAtLeastOne(4);
