BUILDDIR=build
PAGEDIR=pages
STATICDIR=static

PAGES=$(shell find $(PAGEDIR) -type f -name \*.md)
STATICS=$(shell find $(STATICDIR) -type f)
PAGES_BUILT=$(patsubst $(PAGEDIR)/%.md,$(BUILDDIR)/%.html,$(PAGES))
STATICS_BUILT=$(patsubst static/%,$(BUILDDIR)/%,$(STATICS))

TEMPLATE=templates/default.html
LUA_FILTERS=pandoc/filters.lua
PANDOC_FROM=markdown+yaml_metadata_block+wikilinks_title_after_pipe-definition_lists-smart
MD_TO_HTML=pandoc --lua-filter=$(LUA_FILTERS) --from=$(PANDOC_FROM)

TOC_MAKER=npx markdown-toc --maxdepth 5 --no-stripHeadingTags --indent="  " --bullets="-" -i
MARP=npx marp --html
MINIFIER=npx minify

DEVNAME=mun.la

.PHONY: all clean test dev stopdev

all: $(BUILDDIR)/lipu/index.html $(PAGES_BUILT) $(STATICS_BUILT)

clean:
	rm -rf $(BUILDDIR)/*

$(BUILDDIR)/lipu/index.html: blogindex.sh
	@mkdir -p $(@D)
	bash blogindex.sh | $(MD_TO_HTML) \
		--template=$(TEMPLATE) \
		-o $@
	$(MINIFIER) $@ | sponge $@

$(BUILDDIR)/toki/%.html: $(PAGEDIR)/toki/%.md
	@mkdir -p $(@D)
	$(MARP) $< -o $@
	$(MINIFIER) $@ | sponge $@

$(BUILDDIR)/%.html: $(PAGEDIR)/%.md $(TEMPLATE)
	# altered because of publish line
	@mkdir -p $(@D)
	$(TOC_MAKER) $<
	cat $< | sed 's/% published: .*//g' | $(MD_TO_HTML) \
		--template=$(TEMPLATE) \
		--metadata="directory:$(patsubst pages/%.md,%.html,$<)" \
		-o $@
	$(MINIFIER) $@ | sponge $@

$(BUILDDIR)/%: $(STATICDIR)/%
	@mkdir -p $(@D)
	cp -r $< $@

$(BUILDDIR)/%.css: $(STATICDIR)/%.css
	@mkdir -p $(@D)
	cpp $< | sed 's/^#.*//g' > $@
	$(MINIFIER) $@ | sponge $@

test: build/test.html build/style.css build/index.html build/sona/index.html

dev: stopdev
	screen -S $(DEVNAME) -d -m python3 -m http.server -d $(BUILDDIR)
	screen -S $(DEVNAME)-build -d -m bash -c "find pages/ -type f -name '*.md' | entr make -j"

stopdev:
	screen -S $(DEVNAME) -X quit | true
	screen -S $(DEVNAME)-build -X quit | true
