# Create the virtual environment.
make venv
make activate

# Run pre-commit
.venv/bin/pre-commit run
