#import "@preview/wordometer:0.1.6": total-words, word-count
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/cetz:0.5.3": *
#import "@preview/frame-it:2.1.0": *

#let (example, feature, variant) = frames(
  feature: ("Feature",),
  // For each frame kind, you have to provide its supplement title to be displayed
  variant: ("Variant",),
  // You can provide a color or leave it out and it will be generated
  example: ("Example", gray),
)
// This syntax works as well, but colors are not generated automatically
#let syntax = frame("Syntax", green)
// This is necessary. Don't forget this!
#show: frame-style(styles.boxy)
#let default-authors = (
  (
    name: "Paul Elvis Otto",
    affiliation: "European University Institute",
    email: "paulelvis.otto@eui.eu",
  ),
)

#let conf(
  title: [],
  subtitle: [],
  authors: default-authors,
  date: datetime.today(),
  abstract: [],
  doc,
  toc: none,
  columns: columns,
  show-bibliograpy: false,
  show-word-count: false,
) = {
  set page(
    paper: "a4",
    header: align(
      right + horizon,
      subtitle,
    ),
    columns: columns,
    numbering: "1",
  )

  set par(justify: true)
  place(
    top + center,
    float: true,
    scope: "parent",
    clearance: 2em,
    {
      align(center)[#text(20pt)[
        *#title*]]

      align(center)[#text(17pt)[
        #subtitle]]
      let count = authors.len()
      let ncols = calc.min(count, 3)

      grid(
        columns: (1fr,) * ncols,
        align: center,
        row-gutter: 24pt,

        ..authors.map(author => [
          #author.name \
          #author.affiliation \
          #link("mailto:" + author.email) \
          #date.display()

        ]),
      )

      if abstract != none {
        par(justify: true)[
          *Abstract* \
          #abstract
        ]
      }
      if toc != none {
        outline(title: "Table of Contents")
      }
    },
  )
  show: word-count

  doc

  if show-bibliograpy {
    bibliography("references.bib", style: "harvard-cite-them-right")
  }

  if show-word-count {
    [
      *Word Count:* #total-words
    ]
  }
}
