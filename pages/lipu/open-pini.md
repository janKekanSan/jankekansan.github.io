% How common are [open]{.tp} and [pini]{.tp} preverb?
% gregdan3
% 2025-01-20
% published: false

## Background

In its toki pona lessons,
[Toki Pona: The Language of Good](https://www.amazon.com/dp/0978292308) lists
the following six words as preverbs: [wile]{.tp}, [ken]{.tp}, [awen]{.tp},
[kama]{.tp}, [lukin]{.tp}, and [sona]{.tp},

Anecdotally, all of these preverbs are in regular use except for [sona]{.tp}.
For [sona]{.tp}, many people will report to use it, but it is comparatively rare
due to the infrequency of its topic (discussing skills) and the semantic overlap
with its non-preverb form. It is also difficult to study for both of these
reasons.

But if you're active in the community, you'll notice a surprising omission:
[alasa]{.tp}. [alasa]{.tp} was not listed as a preverb in Sonja's book, but it
is considered a core preverb today, with the same meaning as [lukin]{.tp}
preverb: "to try". Summarizing the known history of [alasa]{.tp}, it was
considered a fringe usage in 2017, was becoming popular in 2020 to the point of
being anecdotally described as common, and
[overtook [lukin]{.tp} in popularity in August of 2021](https://ilo.muni.la/?query=alasa+sona+%2B+alasa+toki+%2B+alasa+pali+%2B+alasa+kama+%2B+alasa+ni%2C+lukin+sona+%2B+lukin+toki+%2B+lukin+pali+%2B+lukin+kama+%2B+lukin+ni).

However, if you were active in the community during 2021 or 2022, you might
recall that [open]{.tp} and [pini]{.tp} were frequently discussed as preverbs,
and a fair number of people used them. In fact, you can still find them listed
in the [[lipu sona pona]{.tp} course](https://lipu-sona.pona.la/en/10/) by jan
Lentan, which at the time was on `devurandom.xyz`

But how popular were they as preverbs? How popular are they today? And how can
we know?

## Process

In August 2024, I released [ilo Muni](https://ilo.muni.la), a tool which lets
you graph how much a given toki pona word or phrase has been used over time.
With it, you can very easily study toki pona's grammatical particles, and see
what words or phrases have come into or fallen out of popularity. However, it
can be hard to study preverbs, because many valid preverb constructions look the
same as normal content word constructions. For example, the sentence "[mi
lukin pona e ilo]{.tp}" can have two different meanings:

- If [lukin]{.tp} were a preverb, it would be "I am trying to fix the tool."
- If [lukin]{.tp} were a content word, it would be "I see the tool clearly."

This is actually the exact same issue that [sona]{.tp} preverb has, except that
[sona]{.tp} content word is _much_ more common than [sona]{.tp} preverb. We can
work around this though! First, we need to get all the potential preverb phrases
for a given preverb from ilo Muni's database. Here's my process:

1. Query the ilo Muni database for all 3 word phrases beginning with the target
   preverb.
2. Omit phrases which grammatically cannot be preverb constructions
3. Manually omit all results which are unlikely to be or are not preverbs.
4. Sum the resulting terms onto one big graph in ilo Muni.
5. Compare the prevalence of the preverb with its corresponding content word and
   other content words of a similar level of usage.

This process comes with the following caveats and clarifications:

First: I'm studying 3 word phrases because they are more easily identified as
preverbs or non-preverbs than 2 word phrases. This does mean omitting some data,
mostly for short sentences like "[mi wile ni]{.tp}." But the 2 word phrase
"[wile ni]{.tp}" could appear in the above sentence as a preverb, or in the sentence
[wile ni li pona]{.tp} and not be a preverb. More context is needed!

Second: All phrases I check must begin with the same word, because otherwise we
would double count some preverbs. For example, in "[ona li wile ala ni]{.tp}",
the phrases "[li wile ala]{.tp}" and "[wile ala ni]{.tp}" both cover the
[wile]{.tp} preverb. This is covered in much more detail in
[ilo Muni's help page](https://ilo.muni.la/help/#relative).

Third: Omitting phrases which grammatically cannot be preverbs mostly means
omitting phrases with particles. For example, a 3 word phrase beginning with a
potential preverb is not a preverb if it contains [la]{.tp}, [li]{.tp},
[pi]{.tp}, [en]{.tp}, or [o]{.tp}.

Lastly: Manual omissions are complicated, since they depend on my own intuition
for whether a given phrase is a preverb construction or not. This is complicated
because essentially any valid preverb phrase is a valid content word phrase.
However, my intention is to filter down to those phrases that are preverbs _more
often_ than they are not. As a somewhat contrived example, the phrase "[wile
ala e]{.tp}" could be a preverb if [ala]{.tp} were a verb instead of a modifier,
but it is almost never a preverb because [ala]{.tp} is almost never a verb in
this phase. If you are familiar with toki pona, this makes intuitive sentence:
[ala]{.tp} is most often a special kind of modifier, not a content word.

All of this comes out to the following SQL query for ilo Muni's database:

```sql
SELECT
  p.text AS term
FROM
  term p
  JOIN yearly yr ON p.id = yr.term_id
WHERE
  p.len = 3
  AND yr.min_sent_len = 3
  AND yr.day = 0
  AND p.text GLOB 'wile *'
  AND NOT (
    p.text GLOB 'wile e *'
    OR p.text GLOB 'wile la *' -- not grammatical
    OR p.text GLOB 'wile * la'
    OR p.text GLOB 'wile li *'
    OR p.text GLOB 'wile * li'
    OR p.text GLOB 'wile pi *'
    OR p.text GLOB 'wile * pi'
    OR p.text GLOB 'wile en *'
    OR p.text GLOB 'wile * en'
    OR p.text GLOB 'wile o *'
    OR p.text GLOB 'wile * o'
    OR p.text GLOB 'wile anu *'
    OR p.text GLOB 'wile kin *'
    OR p.text GLOB 'wile a *' -- probable noun phrases
    OR p.text GLOB 'wile * a'
    OR p.text GLOB 'wile * mi'
    OR p.text GLOB 'wile * sina'
    OR p.text GLOB 'wile * ona'
    OR p.text GLOB 'wile mi *'
    OR p.text GLOB 'wile sina *'
    OR p.text GLOB 'wile ona *'
    OR p.text GLOB 'wile tan *' -- probable prep phrase (omitted for kama)
    OR p.text = 'wile ala wile' -- specific exceptions
    OR p.text = 'wile anu seme'
    OR p.text = 'wile ala kin'
    OR p.text = 'wile ala e'
    OR p.text = 'wile ala a'
    OR p.text = 'wile a e'
    OR p.text = 'wile a a'
  )
ORDER BY
  yr.hits DESC;
```

As a quick point of reference:

- Phrases which contain any particles that affect a sentence's structure cannot
  be preverb phrases.
- Phrases with [kin]{.tp} or [a]{.tp} in the middle almost always continue to a
  particle, not a content word, and so cannot be preverbs
- Phrases that have [mi]{.tp}, [sina]{.tp}, or [ona]{.tp} are almost certainly
  noun phrases, not verb phrases beginning with a preverb.

## Demonstration

I'm not going to be able to do a complete demonstration of my process for every
word, because most of them actually have an enormous number of examples, but
[alasa]{.tp} is quite simple. I will repeat this process for [open]{.tp} and
[pini]{.tp} as well, but for the rest I will only show the result.

### alasa

The query returns the following phrases from ilo Muni:

<details>
  <summary> Phrases for [alasa]{.tp} </summary>

- alasa sona e
- alasa pali e
- alasa pona e
- alasa toki e
- alasa kama sona
- alasa pana e
- alasa toki pona
- alasa lukin e
- alasa weka e
- alasa ante e
- alasa moku e
- alasa sitelen e
- alasa moli e
- alasa linja suno
- alasa lon tenpo
- alasa ale anpa
- alasa kepeken ilo
- alasa pini e
- alasa lon ilo
- alasa toki tawa
- alasa wawa e
- alasa ni lon
- alasa sin e

</details>

Out of these, only the following phrase does not include a preverb: [alasa
linja suno]{.tp}.

Once that one is removed, we can throw the rest into ilo Muni:

### wile

<details>
  <summary> All examined preverb phrases for [wile]{.tp} </summary>

```

```

</details>

### ken

<details>
  <summary> All examined preverb phrases for [ken]{.tp} </summary>

```

```

</details>

### awen

<details>
  <summary> All examined preverb phrases for [ken]{.tp} </summary>

```

```

</details>

### kama

<details>
  <summary> All examined preverb phrases for [ken]{.tp} </summary>

```

```

</details>

### lukin

<details>
  <summary> All examined preverb phrases for [ken]{.tp} </summary>

```

```

</details>

### sona

<details>
  <summary> All examined preverb phrases for [ken]{.tp} </summary>

```

```

</details>

## open and pini

### open

<details>
  <summary> All examined preverb phrases for [open]{.tp} </summary>

```

```

</details>

### pini

<details>
  <summary> All examined preverb phrases for [open]{.tp} </summary>

```

```

</details>
