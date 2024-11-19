# Makefile for data analysis pipeline

# Variables
REPO_NAME = your-repo-name
GITHUB_USER = your-github-username
BRANCH = main
SETUP_VENV =true
# set to false to skip venv setup


# Declare phony targets
.PHONY: all init sync push venv_init venv_update data_analysis clean_data analysis make_figures report help

# Default target
all: data_analysis push

# Initialize a local Git repository and push to GitHub
init:
	git init
	git add .
	git commit -m "Initial commit"
	@if [ "$(SETUP_VENV)" = "true" ]; then \
		make venv_init; \
	fi
	make init_repo

init_repo:
	gh repo create $(GITHUB_USER)/$(REPO_NAME) --private --source=. --remote=origin
	git push -u origin $(BRANCH)

# Sync with Github
sync:
	git pull origin $(BRANCH)
	@if [ "$(SETUP_RENV)" = "true" ]; then \
		Rscript -e "renv::restore()"; \
	fi

# Push to GitHub
push:
	git pull origin $(BRANCH)
	@if [ "$(SETUP_VENV)" = "true" ]; then \
		. venv/bin/activate && pip freeze > requirements.txt; \
	fi
	git add -u
	git commit -m "Update analysis and data"
	git push origin $(BRANCH)

# Initialize Python virtual environment
venv_init:
	python3 -m venv venv
	. venv/bin/activate && pip install --upgrade pip setuptools wheel
	@touch requirements.txt  # Create requirements.txt if it doesn't exist
	. venv/bin/activate && pip install -r requirements.txt
	git add -u
	git commit -m "Initialize Python environment with virtualenv"

# Update Python packages
venv_update:
	. venv/bin/activate && pip install --upgrade -r requirements.txt
	git add -u
	git commit -m "Update Python environment dependencies"

# Data analysis workflow
data_analysis: clean_data analysis make_figures report

clean_data:
	python3 src/R/00_clean_data.py

analysis: 
	python3 src/R/01_analysis.py

make_figures: 
	python3 src/R/02_make_figures.py

report: 

# Help target
help:
	@echo "Available targets:"
	@echo "  all          - Run the complete workflow"
	@echo "  init         - Initialize Git repository and push to GitHub"
	@echo "  sync         - Sync local changes with GitHub and restore R environment"
	@echo "  push         - Push changes to GitHub"
	@echo "  venv_init    - Initialize R environment with renv"
	@echo "  venv_update  - Update renv snapshot"
	@echo "  data_analysis- Run the complete data analysis workflow"
	@echo "  clean_data   - Run data cleaning script"
	@echo "  analysis     - Run analysis script (requires clean data)"
	@echo "  make_figures - Generate figures (requires analysis)"
	@echo "  report       - Generate final report (requires analysis and figures)"
	@echo "  help         - Show this help message"
