pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Write a circuit that constrains the 4 input signals to be
// sorted. Sorted means the values are non decreasing starting
// at index 0. The circuit should not have an output.

template IsSorted() {
    signal input in[4];

    component let[4]; 

    var i = 0;
    for (var i = 1; i < 4 ; i++){
        let[i] = LessEqThan(252);
        let[i].in[0] <== in[i-1];
        let[i].in[1] <== in[i];
        let[i].out === 1;
    }

}

component main = IsSorted();
