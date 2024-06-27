const fs = require("fs");
const path = require("path");

const link = process.argv[2];

fetch(link).then(async (response) => {
	const text = (await response.text()).replace(/<script.+?script>/g, "").replace(/<meta.+?\/>/g, "");
	fs.writeFileSync(path.join(__dirname, "Webpage", "index.html"), text);
});
