BUILDDIR=build

PAGEDIR=pages
STATICDIR=static

PAGES=$(shell find $(PAGEDIR) -type f -name \*.md)
STATICS=$(shell find $(STATICDIR) -type f)
TEMPLATE=templates/default.html

PAGES_BUILT=$(patsubst $(PAGEDIR)/%.md,$(BUILDDIR)/%.html,$(PAGES))
STATICS_BUILT=$(patsubst static/%,$(BUILDDIR)/%,$(STATICS))
WIDTH_FIX=pandoc/rm-colgroup.lua
LINK_FIX=pandoc/link-md-to-html.lua

MARP=npx marp --html
MD_TO_HTML=pandoc --lua-filter=$(WIDTH_FIX) --lua-filter=$(LINK_FIX) --from=markdown+yaml_metadata_block+mark+wikilinks_title_after_pipe-definition_lists-smart
MINIFIER=npx html-minifier --config html-minifier.config.json
TOC_MAKER=npx markdown-toc --maxdepth 5 --no-stripHeadingTags --indent="  " --bullets="-" -i

DEVNAME=mun.la

.PHONY: all clean dev stopdev

all: $(BUILDDIR)/lipu/index.html $(PAGES_BUILT) $(STATICS_BUILT)

clean:
	rm -rf $(BUILDDIR)/*

$(BUILDDIR)/lipu/index.html: blogindex.sh
	@mkdir -p $(@D)
	bash blogindex.sh | $(MD_TO_HTML) --template=$(TEMPLATE) -o $@
	$(MINIFIER) $@ -o $@

$(BUILDDIR)/toki/%.html: $(PAGEDIR)/toki/%.md
	@mkdir -p $(@D)
	$(MARP) $< -o $@
	# $(MINIFIER) $@ -o $@  # broken

$(BUILDDIR)/%.html: $(PAGEDIR)/%.md $(TEMPLATE)
	# altered because of publish line
	@mkdir -p $(@D)
	$(TOC_MAKER) $<
	cat $< | sed 's/% published: .*//g' | $(MD_TO_HTML) \
		--template=$(TEMPLATE) \
		--metadata="directory:$(subst pages/,,$<)" \
		-o $@
	$(MINIFIER) $@ -o $@

$(BUILDDIR)/%: $(STATICDIR)/%
	@mkdir -p $(@D)
	cp -r $< $@

$(BUILDDIR)/%.css: $(STATICDIR)/%.css
	@mkdir -p $(@D)
	cp -r $< $@
	$(MINIFIER) $@ -o $@

dev: stopdev
	screen -S $(DEVNAME) -d -m python3 -m http.server -d $(BUILDDIR)

stopdev:
	screen -S $(DEVNAME) -X quit | true
