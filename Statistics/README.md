# Open Source & Developer Experience Analysis

This project investigates the correlation between developer experience and open source contributions using data from the Stack Overflow Developer Survey. It includes a Rust script for processing and analyzing data, along with a simple frontend for interactive visualization.

## 📁 Project Structure

```
 ..
├──  Cargo.lock
├──  Cargo.toml          # Rust dependencies and project metadata
├──  chart               # Frontend files (HTML + JS with Vite)
│   ├──  index.html      # Main overview
│   ├──  iqr.html        # IQR visualization
│   ├──  rho.html        # Spearman's rho scatterplot
│   ├──  server.js       # Simple local server for viewing charts
│   ├──  variance.html   # Variance analysis
│   └──  vite.config.js  # html & js bundler configuration
├──  data
│   └──  '2024 Developer Survey.pdf'
├── 󰂺 README.md           # This file
├──  Research.md         # Research paper
├──  shell.nix
└──  src                 # Rust source files
    ├──  main.rs
    └──  utils.rs
```

## 📊 Data

To run this project, you must manually download the dataset:

1. Go to [Stack Overflow Insights](https://insights.stackoverflow.com/survey)
2. Download the **"2024 Developer Survey Results"** (CSV or Excel format)
3. Extract the relevant data into the `data/` folder (next to the PDF)

> ⚠️ Make sure the dataset is extracted and not just the PDF. The program expects actual data files (e.g., `.csv`).

## ⚙️ How to Run

### Analyzing data (Rust)

You can build and run the backend analysis with:

```bash
cargo run
```

NB: You must have [Rust](https://www.rust-lang.org/tools/install) installed

## Displaying the plots

You can view the plots and charts only after you have analyzed the data with the step above.  
Then, provided that you have [Node](https://nodejs.org/en/download) installed, you can install the dependencies and run the forntend via

```bash
npm i
npm run dev
```

Then open a browser and put the following as the url `http://localhost:5173/` or follow this [link](http://localhost:5173/). In order to view the different plots add the following words at the end of the url:

- [index](http://localhost:5173/) - display the data gathered from Stachoverflow
- variance - View the variance of the **X** and **Y** variables
  - [X](http://localhost:5173/variance?variable=x)
  - [Y](http://localhost:5173/variance?variable=y)
- iqr - View the IQR of the **X** and **Y** variables
  - [X](http://localhost:5173/iqr?variable=x)
  - [Y](http://localhost:5173/iqr?variable=y)
- [rho](http://localhost:5173/rho) - Display the Spearman's rankings
