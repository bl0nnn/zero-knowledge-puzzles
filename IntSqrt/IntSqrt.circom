pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if
// in[0] is the floor of the integer
// sqrt of in[1]. For example:
// 
// int[2, 5] accept
// int[2, 5] accept
// int[2, 9] reject
// int[3, 9] accept
//
// If b is the integer square root of a, then
// the following must be true:
//
// (b - 1)(b - 1) < a
// (b + 1)(b + 1) > a
// 
// be careful when verifying that you 
// handle the corner case of overflowing the 
// finite field. You should validate integer
// square roots, not modular square roots

template IntSqrt(n) {
    signal input in[2];

    var b = in[0];
    var a = in[1];

    component aBits = Num2Bits(252);
    aBits.in <== a;

    component bBits = Num2Bits(126);  //checks that is less than 2^126 cause in[0]**2 max 252
    bBits.in <== b;

    signal bSqr;
    signal nextb;
    signal nextbSqr;
    bSqr <== b*b;
    nextb <== b + 1;
    nextbSqr <== nextb * nextb;

    component geq = GreaterEqThan(252);
    geq.in[0] <== a;
    geq.in[1] <== bSqr;
    geq.out === 1;

    component leq = LessThan(252);
    leq.in[0] <== a;
    leq.in[1] <== nextbSqr;
    leq.out === 1;

}

component main = IntSqrt(252);
