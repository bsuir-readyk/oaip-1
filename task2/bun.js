let res = "";

const length = 33;

/**
 @param {string} a
 @return {string}
 */
function alt(a) {
    return a === "1" ? "0" : "1";
}

let prev = "01";
res+=prev;
for (let i=2; i<length; i++) {
    if (prev === "00") {
        res += "1";
    } else if (prev === "11") {
        res += "0";
    } else {
        res += i%5 === 0 ? prev[0] : prev[1];
    }
    prev = res[i-1] + res[i];
    console.log(prev, res);
}


/**
 * @param {string} x
 * @returns boolean
 * */
function check(x) {
    for (let l=1; l<=x.length/3; l++) {
        for (let i=0; i<x.length/* -l*3 */; i++) {
            console.log("check l:", l, ", i:", i);
            const a1=x.slice(i, i+l),
                a2=x.slice(i+l, i+l*2),
                a3=x.slice(i+2*l, i+l*3);
            if (a1 === a2 && a2 === a3) {
                console.log("\n", x, '\n', l, i, '\n', a1, a2, a3);
                throw new Error("check not passed");
            }
        }
    }
}


check(res);
console.log("success:", res);

