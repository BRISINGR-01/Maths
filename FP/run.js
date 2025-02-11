const { parse } = require("path");

const exec = require("child_process").execSync;

exec("elm make src/Main.elm --output=main.js >/dev/null");

const Elm = require("./main").Elm;
const main = Elm.Main.init();

// Get data from the command line
const args = process.argv.slice(2);
console.log("\n   Input: ", args.join(" "));

// main.ports.get.send({
// 	n: parseInt(args[0]),
// 	val: args[1],
// });
main.ports.get.send({
	a: parseInt(args[0]),
	b: parseInt(args[1]),
	c: parseInt(args[2]),
});

main.ports.put.subscribe((data) => console.log("   Output: " + JSON.stringify(data) + "\n"));
