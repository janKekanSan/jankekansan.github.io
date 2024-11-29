% stacking and scaling (scrap)
% gregdan3
% 2024-10-28
% published: true

here's my variously sized monetary units on the matters of stacking and scaling:

- stacking and scaling is mostly fine in handwriting, **but** only because you
  can make the glyphs as large as you need for them to be readable
- but some combinations are still not great; some glyphs just don't lend
  themselves to stacking/scaling, which can be because the inner space you'd
  scale to is occupied by a feature of the outer glyph, or because the stacked
  glyphs get warped enough to be less recognized, or because the inner glyph
  would be too small anyway.
- stacking and scaling is _almost never okay_ in a font. it might be okay if you
  could make the font especially large, but since you often can't or at least
  frequently do not, stacked/scaled glyphs become unreadable almost immediately.
- related to the above point, none of the popular sitelen pona fonts are clear
  when rendered at discord's default font size! they all seem to be designed
  with larger rendering in mind. but i feel very confident that a font could be
  designed which has highly readable sp at discord's font size considering cjk
  fonts have no trouble making their glyphs readable, and those glyphs are
  almost all much more complex than those in sitelen pona. for my part, nishiki
  teki is very readability-friendly at discord font size.

---

- stacking and scaling also kinda sucks in fonts in the first place because
  there are as much as 2 * (sitelen pona glyphs)^2 combinations- so either you
  implement it programmatically (leading to a lot of ugly, unusable, and
  uninspired combinations) or do a *ton* of work by hand (enough work that it's
  an appreciable portion of *every cjk glyph in unicode) or just accept that
  you're only going to do a few of them (which is fine tbh)
- and a more personal note: i am a software developer, and spend way too long
  staring at computers and not touching grass. as a direct result, my eyes will
  end up worse than most of my peers for my age. there are already a fair number
  of older toki pona speakers whose eyes are already struggling with the
  stacking/scaling issue i've described, or even sitelen pona written in UCSUR.
  the toki pona community at large skews young, so i ask everyone to please be
  considerate of people who do not have eyes as good as yours.
