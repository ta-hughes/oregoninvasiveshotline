package = oregoninvasiveshotline
distribution = psu.oit.arc.$(package)
egg_name = $(distribution)
egg_info = $(egg_name).egg-info

venv ?= .env
venv_python ?= python3.3
bin = $(venv)/bin
site_packages = $(venv)/lib/$(venv_python)/site-packages

arctasks = $(site_packages)/arctasks
arctasks_url = https://github.com/PSU-OIT-ARC/arctasks/archive/master.tar.gz#egg=psu.oit.arc.tasks

env ?= stage

init: $(venv) $(arctasks)
	@$(bin)/runcommand init
reinit: clean-egg-info clean-venv init

venv: $(venv)
$(venv):
	virtualenv -p $(venv_python) $(venv)

install: $(venv) $(egg_info)
	$(venv)/bin/pip install -r requirements.txt
reinstall: clean-install install

egg-info: $(egg_info)
$(egg_info):
	$(bin)/python setup.py egg_info

$(arctasks):
	$(bin)/pip install -f https://pypi.research.pdx.edu/dist/ $(arctasks_url)
install-arctasks: $(arctasks)
reinstall-arctasks: clean-arctasks $(arctasks)

test: install
	@$(bin)/runcommand test
coverage: install
	$(bin)/runcommand coverage

run-services:
	docker network create --driver bridge $(package) || echo "$(package) network exists"
	docker volume create --name $(package)-elasticsearch-data
	docker volume create --name $(package)-postgres-data
	docker-compose --file docker-compose.services.yaml up

run:
	@$(bin)/runcommand runserver

deploy:
	$(bin)/runcommand --echo --env $(env) deploy

clean: clean-pyc
clean-all: clean-build clean-coverage clean-dist clean-egg-info clean-pyc clean-venv
clean-arctasks:
	$(bin)/pip uninstall --yes psu.oit.arc.tasks || echo "ARCTasks not installed"
clean-build:
	rm -rf build
clean-coverage:
	rm -f .coverage
clean-dist:
	rm -rf dist
clean-egg-info:
	rm -rf $(egg_info)
clean-install:
	$(bin)/pip uninstall $(distribution)
clean-pyc:
	find . -name __pycache__ -type d -print0 | xargs -0 rm -r
	find . -name '*.py[co]' -type f -print0 | xargs -0 rm
clean-venv:
	rm -rf $(venv)

.PHONY = \
    init \
    reinit \
    venv \
    install \
    reinstall \
    egg-info \
    install-arctasks \
    reinstall-arctasks \
    test \
    coverage \
    run-services \
    run \
    deploy \
    clean \
    clean-all \
    clean-arctasks \
    clean-build \
    clean-coverage \
    clean-dist \
    clean-egg-info \
    clean-install \
    clean-pyc \
    clean-venv
