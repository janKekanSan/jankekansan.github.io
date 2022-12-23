BUILDDIR=build

PAGEDIR=pages
STATICDIR=static

PAGES=$(shell find $(PAGEDIR) -type f -name \*.md)
STATICS=$(shell find $(STATICDIR) -type f)
TEMPLATE=templates/default.html
REDIRECT=templates/redirect.html

PAGES_BUILT=$(patsubst $(PAGEDIR)/%.md,$(BUILDDIR)/%.html,$(PAGES))
STATICS_BUILT=$(patsubst static/%,$(BUILDDIR)/%,$(STATICS))
LUA_FILTER=rm-colgroup.lua

MD_TO_HTML=pandoc --lua-filter=$(LUA_FILTER) --from=markdown+yaml_metadata_block
MINIFIER=htmlmin --remove-comments --remove-all-empty-space
TOC_MAKER=npx markdown-toc --maxdepth 5 --no-stripHeadingTags --indent="  " --bullets="-" -i
MAPPER=npx markmap --no-open

DEVNAME=mun-la

.PHONY: all clean dev stopdev

all: $(BUILDDIR)/lipu/index.html $(PAGES_BUILT) $(STATICS_BUILT)

clean:
	rm -rf $(BUILDDIR)/*

$(BUILDDIR)/lipu/index.html:
	@mkdir -p $(@D)
	./blogindex.sh | $(MD_TO_HTML) --template=$(TEMPLATE) -o $@
	$(MINIFIER) $@ $@

$(BUILDDIR)/ilo/map.html:
	@mkdir -p $(@D)
	$(MAPPER) pages/ilo/map.md -o $@
	$(MINIFIER) $@ $@

$(BUILDDIR)/%.html: $(PAGEDIR)/%.md $(TEMPLATE)
	@mkdir -p $(@D)
	$(TOC_MAKER) $<
	$(MD_TO_HTML) \
		--template=$(TEMPLATE) \
		--metadata="directory:$(subst pages/,,$<)" \
		-o $@ $<
	$(MINIFIER) $@ $@

$(BUILDDIR)/toki-pona/%.html: $(PAGEDIR)/toki-pona/%.md $(REDIRECT)
	@mkdir -p $(@D)
	$(MD_TO_HTML) \
		--template=$(REDIRECT) \
		--metadata="directory:$(subst $(PAGEDIR)/,,$<)" \
		--metadata="destination:$(patsubst $(PAGEDIR)/toki-pona/%.md,/%.html,$<)" \
		-o $@ $<
	$(MINIFIER) $@ $@

$(BUILDDIR)/%: $(STATICDIR)/%
	@mkdir -p $(@D)
	cp -r $< $@

$(BUILDDIR)/%.css: $(STATICDIR)/%.css
	@mkdir -p $(@D)
	cp -r $< $@
	$(MINIFIER) $@ $@

dev: stopdev
	docker rm $(DEVNAME) | true
	docker run \
		-d \
		--network host \
		-v $(PWD)/$(BUILDDIR):/usr/local/apache2/htdocs \
		--name $(DEVNAME) \
		httpd:2

stopdev:
	docker kill $(DEVNAME) | true
