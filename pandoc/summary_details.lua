function RawBlock(elem)
	if elem.format == "html" then
    if elem.text == "<details>" then
      elem.text = '<details class="details">'
    end
    if elem.text == "<summary>" then
      elem.text = '<summary class="summary">'
    end
	end
	return elem
end
