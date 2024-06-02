---
title: secret test page!
date: 2024-05-30
author: gregdan3
description: a secret test page for all my formatting
image: /art/other/1386294-trashbag.png
---

# Table of Contents

<!-- toc -->

- [Basic formatting](#basic-formatting)
- [Headings](#headings)
- [h1](#h1)
  - [h2](#h2)
    - [h3](#h3)
      - [h4](#h4)
- [Tables](#tables)
- [Lists](#lists)
- [Blockquotes](#blockquotes)
- [Codeblocks](#codeblocks)
- [Images](#images)
- [Checklist](#checklist)
- [Footnote](#footnote)
- [Misc missing or disabled syntax](#misc-missing-or-disabled-syntax)
- [Inline HTML](#inline-html)
  - [Spoilers](#spoilers)
- [Custom CSS](#custom-css)
  - [Info Blocks](#info-blocks)
  - [Blog](#blog)
  - [Toki Pona](#toki-pona)

<!-- tocstop -->

# Basic formatting

**bold text**

_italic text_

**_bold italic text_**

~~strikethrough text~~

==Highlighted text==

`monospaced text`

[link](https://example.com)

[[./test.md|test link]]

---

# Headings

# h1

## h2

### h3

#### h4

##### h5

###### h6

# Tables

| Column1 | Column2 | Column3 |
| ------- | ------- | ------- |
| Item1.1 | Item2.1 | Item3.1 |
| Item1.2 | Item2.2 | Item3.2 |
| Item1.3 | Item2.3 | Item3.3 |
| Item1.4 | Item2.4 | Item3.4 |

|     center aligned     | left aligned  | right aligned | default alignment |
| :--------------------: | :------------ | ------------: | ----------------- |
|        Item1.1         | Item2.1       |       Item3.1 | Item4.1           |
| **_bold italic item_** | Item2.2       |       Item3.2 | `mono item`       |
|        Item1.3         | **bold item** |       Item3.3 | Item4.3           |
|        Item1.4         | Item2.4       |       Item3.4 | Item4.4           |

| Column1 | Column2 | Column3 | Column4 | Column5 |
| --------------- | --------------- | --------------- | --------------- | --------------- |
| Item1.1 | Item2.1 | Item3.1 | Item4.1 | Item5.1 |
| Item1.2 | Item2.2 | | | Item5.2 |
| Item1.3 | Item2.3 | Item3.3 | | Item5.3 |
| | Item2.4 | Item3.4 | Item4.4 | Item5.4 |


---

# Lists

1. first
2. second
3. third

- first
- second
- third

1. first
   - first
   - second
   - third
2. second
3. third

- first
  - first
  - second
  - third
- second
  1. first
  2. second
  3. third
- third

---

# Blockquotes

> blockquote

> blockquote
> 
>  > with a blockquote

---

# Codeblocks

```
generic codeblock
```

```py
# python codeblock
def somefunc(a: int) -> int:
    return a + 5
```

---

# Images

This produces a `figure` and `figcaption` element

![alt text](toki/mi-lon-ilo/MRI.jpg)

# Checklist

- [x] one
- [ ] two
- [ ] three

# Footnote

Sentence with a footnote [^1]

Sentence with a much longer footnote [^2]

Sentence with an inline footnote^[the inline content chills right here next to the sentence]

[^1]: footnote
[^2]: A much longer footnote which even has built in [toki pona]{.tokipona}

# Misc missing or disabled syntax

Some statement needing context [@reference]

[@reference]: mu anpa

@gregdan3 says whatever.

@gregdan3 [p.69] says bruh.

term
: definition

[toki]{.tokipona}
: speech, language, thought

~Subscript text~

^Superscript text^

:joy: emoji

> [!IMPORTANT]
> Important from github syntax!

something else

> [!CAUTION]
> Caution from github syntax!

# Inline HTML

## Spoilers

<details>
<summary>Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat.</summary>

Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet. Nisi anim cupidatat excepteur officia. Reprehenderit nostrud nostrud ipsum Lorem est aliquip amet voluptate voluptate dolor minim nulla est proident. Nostrud officia pariatur ut officia. Sit irure elit esse ea nulla sunt ex occaecat reprehenderit commodo officia dolor Lorem duis laboris cupidatat officia voluptate. Culpa proident adipisicing id nulla nisi laboris ex in Lorem sunt duis officia eiusmod. Aliqua reprehenderit commodo ex non excepteur duis sunt velit enim. Voluptate laboris sint cupidatat ullamco ut ea consectetur et est culpa et culpa duis.

</details>

<details>
<summary>

> blockquote inside summary

</summary>

irrelevant details

</details>

<details>
<summary>

blockquote inside details

</summary>

> blockquote inside details with Lorem ipsum dolor sit amet, qui minim labore adipisicing minim sint cillum sint consectetur cupidatat. Lorem ipsum dolor sit amet, officia excepteur ex fugiat reprehenderit enim labore culpa sint ad nisi Lorem pariatur mollit ex esse exercitation amet. Nisi anim cupidatat excepteur officia. Reprehenderit nostrud nostrud ipsum Lorem est aliquip amet voluptate voluptate dolor minim nulla est proident. Nostrud officia pariatur ut officia. Sit irure elit esse ea nulla sunt ex occaecat reprehenderit commodo officia dolor Lorem duis laboris cupidatat officia voluptate. Culpa proident adipisicing id nulla nisi laboris ex in Lorem sunt duis officia eiusmod. Aliqua reprehenderit commodo ex non excepteur duis sunt velit enim. Voluptate laboris sint cupidatat ullamco ut ea consectetur et est culpa et culpa duis.

</details>

# Custom CSS

## Info Blocks

::: info

Important things to know!

:::

::: warning

Potentially harmful or misleading info you are being warned against!

:::

::: error

Dangerous misunderstandings ahead! Exercise maximum caution!

:::

---

::: info

Some normal info!

> Blockquote inside normal info!

:::

::: warning

Some warning info!

> Blockquote inside warning info!

:::

::: error

Some error info!

> Blockquote inside error info!

:::

---

::: info

Some normal info!

<details>
<summary>Summary content inside info</summary>

Details content under summary inside info

</details>

:::

::: warning

Some warning info!

<details>
<summary>Summary content inside info</summary>

Details content under summary inside info

</details>

:::

::: error

Some error info!

<details>
<summary>Summary content inside info</summary>

Details content under summary inside info

</details>

:::

## Blog

::: blogentry
[[title of the blog](https://example.com)]{.bloglink} (blog date)

[some blog entry content]{.blogdetails}
:::

::: blogentry
[[[toki pona li pona tawa mi]{.tokipona}](https://example.com)]{.bloglink}

[[mi toki wawa lon toki pona kepeken nasin ni]{.tokipona}]{.blogdetails}
:::

## Toki Pona

::: tokipona

> mi unpa e mama sina, aaaaa

:::

[mi toki tawa sina]{.tokipona}

::: tokipona

mi toki suli tawa sina

ni li nasa anu seme

:::

> [mi toki tawa sina lon poki toki lili]{.tokipona}

::: tokipona

_mun_ li moli la seme? lon poka pi tenpo moli la mun pi suli wawa li kama suli sin. ona li mute wawa e suli ona tan ni: mun li lon la ona li wan e kon lon insa. ni li wawa e ona li seli e ona li suno wawa e ona. kon li kama wan la ona li kama kon ante. kon ni kin li ken wan. pini la kiwen taso li lon. kiwen ni li wile e wawa tawa wan la mun mute li ken ala wan e kiwen. mun pi suli wawa li ken wan e kiwen tan ni: suli ona li pana e wawa sin. wawa ni li ken wan e kiwen. taso, pini o lon. wawa li pini la kon ale li wan li kama kiwen. kiwen ale li wan li kama kiwen wawa. tenpo la mun li kama ken ala wan e ijo lon insa ona. ni la mun li lon poka moli. ale pi insa mun li wan la insa ona li alasa weka e insa ona. ona li kama suli li kama loje tan wawa pi kiwen insa tan alasa weka. ona li kama suli la ona li moku e ijo mute lon poka tan suli sin ona. tenpo la wawa pi kiwen insa kin li pini. ni la kama suli ona li pini. wawa pi suli ona li awen lon. ni li taso. wawa pi suli ona li lili e ona li moku e sijelo ona. ni la ale mun li kama lon ma lili wan. ale mun li mute mute mute a! ijo mute li lon ma lili wan la ijo nasa li kama: ijo mun li kama lupa. lupa ni li moku wawa e ijo ale lon poka tan wawa ona. ona li moku e mun ante e ma ale. wawa ona li nasa e nasin tenpo lon poka. sina lon poka ona la sina ken ala weka tan wawa ona. sina alasa weka la sina ken kama lukin e monsi sina tan nasa ma tan nasa tenpo. lupa ni li wawa li nasa.

:::

|                              Word                               | Definition                                             | Writing                                                      |
| :-------------------------------------------------------------: | ------------------------------------------------------ | ------------------------------------------------------------ |
|            [wile]{.glyph}<br/>[wile]{.glyphsubtitle}            | want, need, to want                                    | Curvy letter "w"                                             |
|               [a]{.glyph}<br/>[a]{.glyphsubtitle}               | (mark exclamation, excitement, emphasis)               | Letter "a" beneath a vertical line like an exclamation point |
| [kijetesantakalu]{.glyph}<br/>[kijetesantakalu]{.glyphsubtitle} | **raccoon, procyonid, musteloid, skrunkly mammal**     | **raccoon**                                                  |
|            [lipu]{.glyph}<br/>[lipu]{.glyphsubtitle}            | paper, card, document, website, leaf, small flat thing | Tall rectangle like a piece of paper                         |
|            [pali]{.glyph}<br/>[pali]{.glyphsubtitle}            | create, work, creation                                 | A hand shape with a circle above it                          |
