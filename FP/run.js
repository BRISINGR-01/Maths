const { parse } = require("path");

const exec = require("child_process").execSync;

exec("elm make src/Main.elm --output=main.js >/dev/null");

const Elm = require("./main").Elm;
const main = Elm.Main.init();

// Get data from the command line
const args = process.argv.slice(2);
console.log(args);

// N
// console.log("\n   Input: ", args[0], ",", args.slice(1).join(" "));
// main.ports.get.send(parseInt(args[0]));

// Ceasar
// console.log("\n   Input: ", args[0], ",", args.slice(1).join(" "));
// main.ports.get.send({
// 	offset: parseInt(args[0]),
// 	val: args.slice(1).join(" "),
// });

// console.log("\n   Input: ", args.join(", "));
// main.ports.get.send({
// 	a: parseInt(args[0]),
// 	b: parseInt(args[1]),
// 	c: parseInt(args[2]),
// });

// Credit cards, Merge
// console.log("\n   Input: ", args[0]);
// main.ports.get.send(args[0]);

// Math
console.log("\n   Input: ", args[0]);
main.ports.get.send(parseFloat(args[0]));

main.ports.put.subscribe((data) => console.log("   Output: " + JSON.stringify(data) + "\n"));
