DIFF ?= diff --strip-trailing-cr -u

all: test

.PHONY: test
test: test_html test_latex
	@echo Test complete.

.PHONY: generate
generate: expected.html expected.tex test.pdf

test_html: README.md columns.lua
	@pandoc --lua-filter columns.lua --standalone --to=html $< \
	    | $(DIFF) expected.html -

test_latex: README.md columns.lua
	@pandoc --lua-filter columns.lua --standalone --to=latex $< \
	    | $(DIFF) expected.tex -

expected.html: README.md columns.lua
	pandoc --lua-filter columns.lua --standalone --output $@ $<

expected.tex: README.md columns.lua
	pandoc --lua-filter columns.lua --standalone --output $@ $<

test.pdf: README.md columns.lua
	pandoc --lua-filter columns.lua --standalone --output $@ $<