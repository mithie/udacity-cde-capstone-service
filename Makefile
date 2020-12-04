setup:
	python3 -m venv venv
	#source venv/bin/activate

install:
	pip install --upgrade pip && \
	pip install -r requirements.txt

lint:
	#hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1202 app.py

all: setup install lint
