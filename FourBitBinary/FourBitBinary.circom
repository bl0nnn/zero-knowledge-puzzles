pragma circom 2.1.8;

include "../node_modules/circomlib/circuits/bitify.circom";


// Create a circuit that takes an array of four signals
// `in`and a signal s and returns is satisfied if `in`
// is the binary representation of `n`. For example:
// 
// Accept:
// 0,  [0,0,0,0]
// 1,  [0,0,0,1]
// 15, [1,1,1,1]
// 
// Reject:
// 0, [3,0,0,0]
// 
// The circuit is unsatisfiable if n > 15

template FourBitBinary() {
    signal input in[4];
    signal input n;

    component b2n = Bits2Num(4);    //bits2num works in little endian notation!!!

    var j = 0;
    for (var i = 3; i >= 0; i--){
        b2n.in[j] <== in[i];
        j++;
    }

    b2n.out === n;

}

component main{public [n]} = FourBitBinary();
