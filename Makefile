.PHONY: html-files css-files spell-files lint lint-html lint-css spell format format-html format-css check-format check-format-html check-format-css

# Find all HTML files in the repository (excluding .git metadata).
HTML_FILES := $(shell find . -type f -name '*.html' -not -path './.git/*')

# Find repository CSS files and skip bundled third-party icon packs.
CSS_FILES := $(shell find . -type f -name '*.css' -not -path './.git/*' -not -path './css/font-awesome/*' -not -path './css/fontello/*')

# Spell-check docs and markup content.
SPELL_FILES := $(shell find . -type f \( -name '*.html' -o -name '*.md' \) -not -path './.git/*')

html-files:
	@printf '%s\n' $(HTML_FILES)

css-files:
	@printf '%s\n' $(CSS_FILES)

spell-files:
	@printf '%s\n' $(SPELL_FILES)

lint-html:
	@npx --yes htmlhint $(HTML_FILES)

lint-css:
	@npx --yes csslint $(CSS_FILES)

lint: lint-html lint-css

spell:
	@npx --yes cspell --config cspell.json $(SPELL_FILES)

format-html:
	@npx --yes prettier --write $(HTML_FILES)

format-css:
	@npx --yes prettier --write $(CSS_FILES)

format: format-html format-css

check-format-html:
	@npx --yes prettier --check $(HTML_FILES)

check-format-css:
	@npx --yes prettier --check $(CSS_FILES)

check-format: check-format-html check-format-css