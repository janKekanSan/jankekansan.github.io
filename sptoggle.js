function toggle() {
  var stylesheet = document.styleSheets[0];
  var elementRules;
  for (var i = 0; i < stylesheet.cssRules.length; i++) {
    if (stylesheet.cssRules[i].selectorText === ".tokipona") {
      elementRules = stylesheet.cssRules[i];
      break; // TODO: so lazy
    }
  }
  var current = elementRules.style.getPropertyValue("font-family");
  if (current !== "sp") {
    elementRules.style["font-family"] = "sp";
  } else {
    elementRules.style["font-family"] = "";
  }
}
