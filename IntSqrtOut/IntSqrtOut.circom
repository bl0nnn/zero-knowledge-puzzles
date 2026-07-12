pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Be sure to solve IntSqrt before solving this 
// puzzle. Your goal is to compute the square root
// in the provided function, then constrain the answer
// to be true using your work from the previous puzzle.
// You can use the Bablyonian/Heron's or Newton's
// method to compute the integer square root. Remember,
// this is not the modular square root.


function intSqrtFloor(x) {
    if (x < 2){
        return x;
    }

    var guess = x \ 2;
    var next_guess = 0;

    var i = 0;
    while(i < 127) {
        next_guess = (guess+x\guess)\2;
        if (next_guess >= guess){
            return guess;
        }
        guess = next_guess;
        i++; 
    }
    return guess;
}

template IntSqrtOut(n) {
    signal input in;
    signal output out;

    component inBits = Num2Bits(126);   //max 126 cause then we will do ^2
    inBits.in <== in;

    out <-- intSqrtFloor(in);
    
    signal outSqr;
    signal nextOut;
    signal nextOutSqr;

    outSqr <== out * out;
    nextOut <== out + 1;
    nextOutSqr <== nextOut * nextOut;

    component geq1 = GreaterEqThan(252);
    geq1.in[0] <== in;
    geq1.in[1] <== outSqr;
    geq1.out === 1;

    component leq1 = LessThan(252);
    leq1.in[0] <== in;
    leq1.in[1] <== nextOutSqr;
    leq1.out === 1;
}

component main = IntSqrtOut(252);
