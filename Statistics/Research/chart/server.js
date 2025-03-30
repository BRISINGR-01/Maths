const express = require("express");
const path = require("path");

const app = express();
const PORT = 3000;

app.use((req, res, next) => {
	res.setHeader("Access-Control-Allow-Origin", "*");
	next();
});

// Serve static files from "public"
app.use(express.static(path.join(__dirname)));
app.use(express.static(path.join(__dirname, "../data")));

// Serve node_modules (for ESM imports in the browser)
app.use("/node_modules", express.static(path.join(__dirname, "node_modules")));

app.listen(PORT, () => {
	console.log(`Server running at http://localhost:${PORT}`);
});
