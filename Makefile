# Consistent set of make tasks.
.DEFAULT_GOAL:= help  # because it's is a safe task.

clean:  # Remove all build, test, coverage and Python artifacts.
	rm -rf .venv
	rm -rf lady_penelope.egg-info
	find . -name "*.pyc" -exec rm -f {} \;
	find . -type f -name "*.py[co]" -delete -or -type d -name "__pycache__" -delete
	rm -rf .R/library/*

docker:  # Build tag and push the docker image
	docker build \
		-t ghcr.io/joejcollins/lady-penelope:latest \
		-f Dockerfile \
		--target development .
	# echo $$REPO_AND_PACKAGES_TOKEN | docker login ghcr.io -u joejcollins --password-stdin
	# docker push ghcr.io/joejcollins/lady-penelope:latest

.PHONY: docs  # because there is a directory called docs.
docs:  # Build the Sphinx documentation.
	rm -rf site
	.venv/bin/sphinx-build --builder html docs site

docs-serve: # Serve the Sphinx documentation.
	.venv/bin/python -m http.server --directory site

.PHONY: help
help: # Show help for each of the makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

kill: # Kill the servers on ports from Flask to Rstudio.
	lsof -i tcp:5000-8787 | awk 'NR!=1 {print $$2}' | xargs kill 2>/dev/null || true

lint:  # Lint the code with ruff and mypy.
	.venv/bin/python -m ruff check ./src ./tests
	.venv/bin/sourcery login --token $$SOURCERY_TOKEN
	.venv/bin/python -m mypy ./src ./tests

lock:  # Create the lock file and requirements file.
	rm -f requirements.txt
	uv pip compile pyproject.toml --python .venv/bin/python --output-file=requirements.txt  requirements.in

r:  # Run Rstudio server
	sudo su - rstudio -c 'rserver'

report:  # Report the python version and pip list.
	.venv/bin/python --version
	uv pip list -v

test:  # Run the unit tests.
	.venv/bin/pytest ./tests --verbose --color=yes
	.venv/bin/pytest --cov=lady_penelope --cov-fail-under=20

venv:  # Create the virtual environment.
	uv venv .venv
	uv pip install --python .venv/bin/python --requirements requirements.txt