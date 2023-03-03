SHELL := /usr/bin/bash
VERSION := $(shell grep "version" setup.cfg | cut -f3 -d" ")
.ONESHELL:

install:
	python3 -m venv .venv
	. .venv/bin/activate
	python -m pip install --upgrade pip
	python -m pip install --upgrade setuptools wheel
	python -m pip install -e .[dev]


clean:
	rm -rf .venv
	rm -rf build
	rm -rf *.egg-info

typecheck:
	. .venv/bin/activate
	mypy ./my-app

format:
	. .venv/bin/activate
	@isort ./my-app ./tests
	@black ./my-app ./tests
	@docformatter --in-place ./my-app ./tests

lint:
	. .venv/bin/activate
	flake8 ./my-app
	pylint ./my-app

test:
	. .venv/bin/activate
	pytest -vv -s

changelog:
	. .venv/bin/activate
	towncrier
