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
	mypy ./main-app

format:
	. .venv/bin/activate
	@isort ./main-app ./tests
	@black ./main-app ./tests
	@docformatter --in-place ./main-app ./tests

lint:
	. .venv/bin/activate
	flake8 ./main-app
	pylint ./main-app

test:
	. .venv/bin/activate
	pytest -vv -s

changelog:
	. .venv/bin/activate
	towncrier
