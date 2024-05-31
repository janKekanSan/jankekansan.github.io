-- Substitute links ending in `.md` for `.html`
function Link(el)
	el.target = string.gsub(el.target, "%.md", ".html")
	return el
end
