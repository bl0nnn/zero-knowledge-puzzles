pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Create a circuit that is satisfied if `numerator`,
// `denominator`, `quotient`, and `remainder` represent
// a valid integer division. You will need a comparison check, so
// we've already imported the library and set n to be 252 bits.
//
// Hint: integer division in Circom is `\`.
// `/` is modular division
// `%` is integer modulus

template IntDiv(n) {
    signal input numerator;
    signal input denominator;
    signal input quotient;
    signal input remainder;

    component isz = IsZero();
    isz.in <== denominator;
    isz.out === 0;

    component geq = GreaterEqThan(n);
    geq.in[0] <== remainder;
    geq.in[1] <== 0;
    geq.out === 1;

    component lt = LessThan(n);
    lt.in[0] <== remainder;
    lt.in[1] <== denominator;
    lt.out === 1;

    numerator === quotient * denominator + remainder;

}

component main = IntDiv(252);
