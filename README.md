# Template for R Data Analysis Project


## Project Organization

- `raw_data/`: Original, immutable data (read-only)
- `data/`: Cleaned data ready for analysis
- `docs/`: Documentation
  - `notes.md`: Notes on the project: To-Do, Discussions, etc.
- `src/R/`: Numbered analysis scripts showing workflow
  - `00_clean_data.R`: Data cleaning and preprocessing
  - `01_analysis.R`: Model fitting and analysis
  - `02_make_figures.R`: Figure generation
  - `03_report.Rmd`: Final report generation
- `sandbox/`: Exploratory analysis scripts
- `figs/`: Generated figures
- `refs/`: Reference materials

## Getting Started

1. Clone this template:
```bash
git clone <repository-url>
```

2. Set up the R environment:
```bash
Rscript -e "renv::init()"
Rscript -e "renv::restore()"
```

3. Data Protection

	To prevent accidental modification of raw data:

	3.1. Set files to read-only:
	```bash
	chmod 444 *.csv
	```

	3.2. Add to .gitignore if data is sensitive:
	```gitignore
	raw_data/*
	```

## Analysis Pipeline

```bash
make clean_data   # Run data cleaning script
make analysis     # Run analysis script (requires clean data)
make make_figures # Generate figures (requires analysis)
make report       # Generate final report (requires analysis and figures)
make data_analysis # Run the complete data analysis workflow
make all          # Run the complete workflow and push to GitHub
```

## Data Documentation

Document the source and date of acquisition for each dataset:

- `raw_data/data.csv`: Original data (Source: from [link], Date acquired: YYYY-MM-DD)
- `data/clean_data.csv`: Main cleaned dataset (generated by `R/00_clean_data.R`)
- `data/model_data.csv`: Data prepared for modeling (generated by `R/01_fit_models.R`)

