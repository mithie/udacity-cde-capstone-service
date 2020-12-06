setup:
	# Create python virtualenv
	# needs to be sourced when pyhton should be executed in the virtual environment: source venv/bin/activate
	python -m venv venv

install:
	# This should be run from inside a virtualenv
	pip install --no-cache-dir --upgrade pip==20.3.1 && \
	pip install --no-cache-dir -r requirements.txt

lint_docker:
	# This is a linter for Dockerfiles
	hadolint Dockerfile
	
lint_python:
	# This is a linter for Python source code: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1202 app.py

all: setup install lint
