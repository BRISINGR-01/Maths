import { defineConfig } from "vite";

export default defineConfig({
	root: ".", // Set the root folder for Vite to look for index.html
	server: {
		open: true, // Automatically open the browser
	},
	build: {
		outDir: "./dist", // Output directory after building
	},
});
