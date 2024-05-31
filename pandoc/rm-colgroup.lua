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
