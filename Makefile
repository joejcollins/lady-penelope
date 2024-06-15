# Consistent set of make tasks.
.DEFAULT_GOAL:= help  # because it's is a safe task.

clean:  # Remove all build, test, coverage and Python artifacts.
	rm -rf .venv
	rm -rf lady_penelope.egg-info
	find . -name "*.pyc" -exec rm -f {} \;
	find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete
	rm -rf .R/library/*

compile:  # Compile the requirements files using pip-tools.
	rm -f requirements.*
	.venv/bin/pip-compile --output-file=requirements.txt

docker:  # Build tag and push the docker image
	docker build \
		-t ghcr.io/joejcollins/lady-penelope:latest \
		-f Dockerfile \
		.
	echo $$REPO_AND_PACKAGES_TOKEN | docker login ghcr.io -u joejcollins --password-stdin
	docker push ghcr.io/joejcollins/lady-penelope:latest

.PHONY: help
help: # Show help for each of the makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

kill: # Kill the servers on ports from Flask to Rstudio.
	lsof -i tcp:5000-8787 | awk 'NR!=1 {print $$2}' | xargs kill 2>/dev/null || true

lint:  # Lint the code with ruff and sourcery.
	.venv/bin/python -m ruff check ./python_src ./tests
	.venv/bin/sourcery login --token $$SOURCERY_TOKEN
	.venv/bin/sourcery review ./python_src ./tests --check --no-summary

mypy:  # Type check the code with mypy.
	.venv/bin/python -m mypy ./python_src ./tests

report:  # Report the python version and pip list.
	whoami
	.venv/bin/python --version
	.venv/bin/python -m pip list -v
	Rscript -e "installed_packages <- as.data.frame(installed.packages()); \
		print(installed_packages[c('Package', 'LibPath')])"

venv:  # Install the requirements for Python and R.
	python3 -m venv .venv
	.venv/bin/python -m pip install --upgrade pip setuptools
	.venv/bin/python -m pip install -r requirements.txt
	Rscript "setup.R"

test:  # Run the tests.
	.venv/bin/python -m pytest ./tests/pytest
	Rscript -e "testthat::test_dir('tests')"