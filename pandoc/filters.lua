-- Substitute links ending in `.md` for `.html`
function Link(elem)
	elem.target = string.gsub(elem.target, "%.md", ".html")
	return elem
end

-- Unset the width attribute of HTML colspecs in tables
-- See https://github.com/jgm/pandoc/issues/8139
-- Pandoc assigns width to columns based on longest member
-- It wants width to be static, but ligatures violate this assumption
function Table(tbl)
	if PANDOC_VERSION[1] <= 2 and PANDOC_VERSION[2] < 10 then
		for i, w in ipairs(tbl.widths) do
			tbl.widths[i] = 0
		end
	else
		tbl.colspecs = tbl.colspecs:map(function(colspec)
			local align = colspec[1]
			local width = nil -- default width
			return { align, width }
		end)
	end
	return tbl
end

-- Add a class onto summary and details elements
-- This is a patch for the Nintendo DS browser,
-- since it trashes rules for unrecognized elements
-- but doesn't trash rules for classes
function RawBlock(html)
	if html.format == "html" then
		if html.text == "<details>" then
			html.text = '<details class="details">'
		end
		if html.text == "<summary>" then
			html.text = '<summary class="summary">'
		end
	end
	return html
end

local function setLangTok(el)
  local hasClass = false
  for i, val in ipairs(el.classes) do
    if val == "tp" or val == "tokipona" then
      hasClass = true
      break
    end
  end

  if hasClass then
    el.attributes.lang = "tok"
  end

  return el
end

function Div(el)
  return setLangTok(el)
end

function Span(el)
  return setLangTok(el)
end
