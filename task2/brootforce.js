/**
 * @param {number} length
 * @returns string
 * */
function solve(length) {
    let prev = "10";
    let res = prev;

    for (let i=2; i<length; i++) {
        if (prev === "00") {
            res += "1";
        } else if (prev === "11") {
            res += "0";
        } else {
            res += Math.random() < 0.5 ? "1" : "0";
        }
        prev = res[i-1] + res[i];
    }

    return res;
}

/**
 * @param {string} x
 * @returns boolean
 * */
function check(x) {
    for (let l=1; l<=x.length; l++) {
        for (let i=0; i<x.length/* -l*3 */; i++) {
            const a1=x.slice(i, i+l),
                a2=x.slice(i+l, i+l*2),
                a3=x.slice(i+2*l, i+l*3);
            if (a1 === a2 && a2 === a3) {
                // console.log("\n", x, '\n', l, i, '\n', a1, a2, a3);
                return false
            }
        }
    }
    return true;
}

let ITERATE = true;
let cnt = 0;
try {
    while (ITERATE) {
        const a = solve(50);
        cnt++;
        if (check(a)) {
            console.log("success:", a);
            // throw "solved";
        }
    }
} catch (e) {
    console.error(e);
    console.log("cnt:", cnt);
}

