pragma circom 2.1.8;
include "../node_modules/circomlib/circuits/comparators.circom";

// Use the same constraints from IntDiv, but this
// time assign the quotient in `out`. You still need
// to apply the same constraints as IntDiv

function divisionQuotient(num, den) {

    var quo = num \ den;
    
    return quo;
}

function divisionReminder(num, den) {

    var rem = num % den;

    return rem;
}


template IntDivOut(n) {
    signal input numerator;
    signal input denominator;
    signal output out;


    component isz = IsZero();
    isz.in <== denominator;
    isz.out === 0;


    signal divRes;
    signal divRem;
    divRes <-- divisionQuotient(numerator, denominator);
    divRem <-- divisionReminder(numerator, denominator);

    component geq = GreaterEqThan(n);
    geq.in[0] <== divRem;
    geq.in[1] <== 0;
    geq.out === 1;

    component lt = LessThan(n);
    lt.in[0] <== divRem;
    lt.in[1] <== denominator;
    lt.out === 1;

    numerator === divRes * denominator + divRem;

    out <== divRes;

}

component main = IntDivOut(252);
