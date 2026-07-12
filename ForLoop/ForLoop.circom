pragma circom 2.1.4;

// Input : 'a',array of length 2 .
// Output : 'c 
// Using a forLoop , add a[0] and a[1] , 4 times in a row .

template ForLoop() {

    signal input a[2];
    signal output c;

    signal sum;
    signal s[4];
    
    sum <== a[0] + a[1];
    s[0] <== sum;
    for (var i = 1; i < 4; i++){
        s[i] <== s[i-1] + sum;
    }

    c <== s[3];

}  

component main = ForLoop();
