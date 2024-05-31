"use strict";
function toggle() {
  const stylesheet = document.styleSheets[0];
  let elementRules;
  for (let i = 0; i < stylesheet.cssRules.length; i++) {
    if (stylesheet.cssRules[i].selectorText === ".tokipona") {
      elementRules = stylesheet.cssRules[i];
      break; // TODO: so lazy
    }
  }

  let current = elementRules.style.getPropertyValue("font-family");
  if (current === "") {
    elementRules.style["font-family"] = "sp";
  } else {
    elementRules.style["font-family"] = "";
  }
}
