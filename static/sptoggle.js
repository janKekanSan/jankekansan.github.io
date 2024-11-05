function toggle() {
  var button = document.getElementById("sptoggle");

  var stylesheet = document.styleSheets[0];
  var elementRules;
  for (var i = 0; i < stylesheet.cssRules.length; i++) {
    if (stylesheet.cssRules[i].selectorText === ".tokipona, .tp") {
      elementRules = stylesheet.cssRules[i];
      break; // TODO: so lazy
    }
  }
  var current = elementRules.style.getPropertyValue("font-family");
  if (current !== "sp") {
    elementRules.style["font-family"] = "sp";
    button.ariaPressed = "false";
  } else {
    elementRules.style["font-family"] = "";
    button.ariaPressed = "true";
  }
}
