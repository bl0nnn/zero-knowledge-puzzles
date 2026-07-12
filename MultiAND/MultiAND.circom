pragma circom 2.1.8;

include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that takes an array of signals `in` and
// returns 1 if all of the signals are 1. If any of the
// signals are 0 return 0. If any of the signals are not
// 0 or 1 the circuit should not be satisfiable.

template MultiAND(n) {
    signal input in[n];
    signal output out;

    in[0] * (1 - in[0]) === 0;

    signal intermediate_out[n];
    intermediate_out[0] <== in[0];
    for (var i = 1; i < n; i++){
        in[i] * (1 - in[i]) === 0;
        intermediate_out[i] <== in[i] * intermediate_out[i-1];
    }

    out <== intermediate_out[n-1];

}

component main = MultiAND(4);
