let startS = "1";
for(let i=0; i<49; i++) { startS += "0"; }

let startN = parseInt(startS, 2);

function check(value) {
	const str = value.toString(2);
	for (let ln=1; ln<=str.length/3; ln++) {
		for(let j=0; j<str.length-ln*3; j++) {
			const parts = [str.slice(j, ln), str.slice(j+ln, ln), str.slice(j+ln+ln, ln)];
			if (parts[0] === parts[1] && parts[1] === parts[2]) {
				return false;
			}
		}
	}
	return true;
}

const step = 10_000_000;
let cur = 0;
let result = "";

const startT = new Date().getTime();
console.log(startT);
while(startN.toString(2).length < 51) {
	cur++;
	cur % step === 0 && console.log((new Date().getTime()-startT)/1000/1000);
	// console.log(startN.toString(2).length, "< 51; ", startN.toString(2), startN);
	if (check(startN) && startN.toString(2)) {
		result += ("!!!!!!!", startN.toString(2), startN);
		result += "\n";
	}

	startN++;
}

