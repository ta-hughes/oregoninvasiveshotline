package = oregoninvasiveshotline
distribution = psu.oit.arc.$(package)
egg_name = $(distribution)
egg_info = $(egg_name).egg-info

venv ?= venv
venv_python ?= python3
bin = $(venv)/bin


client_dependencies:  ## Builds npm dependencies and copies built ('dist') artifacts into static collection directory.
	@yarn install
	@echo "Installing js-cookie..."
	@cp node_modules/js-cookie/src/js.cookie.js oregoninvasiveshotline/static/js/
	@echo "Installing jQuery..."
	@cp node_modules/jquery/dist/*.min.* oregoninvasiveshotline/static/js/
	@echo "Installing bootstrap..."
	@cp node_modules/bootstrap/dist/js/*.min.js* oregoninvasiveshotline/static/js/
	@cp node_modules/bootstrap/dist/css/*.min.css* oregoninvasiveshotline/static/css/
	@cp node_modules/bootstrap/dist/fonts/* oregoninvasiveshotline/static/fonts/
	@echo "Installing sentry/browser + sentry/tracing..."
	@cp node_modules/@sentry/tracing/build/bundle.tracing.min.js oregoninvasiveshotline/static/js/sentry.browser.min.js


.PHONY = client_dependencies
