#import "../common/acronyms.typ": usedAcronyms, acronyms
//#import "../common/acronyms.typ": *
#import "@preview/hydra:0.2.0": hydra

#let style(
  title: "",
  titleGerman: "",
  degree: "",
  program: "",
  supervisor: "",
  advisors: (),
  author: "",
  studentNumber: "",
  startDate: none,
  submissionDate: none,
  body,
) = {
  set document(title: title, author: author)
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 3cm,
      left: 4cm,
      right: 2cm
    ),
    numbering: "I",
    number-align: right,
    header:{
      set align(right)
      set text(style: "italic") //should be size 10pt but looks shitty
      hydra(fallback-next: true, top-margin: 3cm)
      v(-8pt)
      line(length: 100%, stroke: 0.5pt + black)
    }
  )

  //let body-font = "New Computer Modern"
  //let sans-font = "New Computer Modern Sans"

  let body-font = "Times New Roman"
  let sans-font = "Times New Roman"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "de"
  )
  
  show math.equation: set text(weight: 400)

  // --- Headings ---
  show heading: set block(below: 1.4em, above: 1.75em)
  show heading: set text(font: body-font)
  set heading(numbering: "1.1")
  
  // spacing within heading blocks
  show heading.where(numbering: "1.1", level: 1): it => block({
    box(width: 25pt, counter(heading).display())
    it.body
  })
  show heading.where(numbering: "1.1", level: 2): it => block({
    box(width: 30pt, counter(heading).display())
    it.body
  })  
  show heading.where(numbering: "1.1", level: 3): it => block({
    box(width: 30pt, counter(heading).display())
    it.body
  })  

  show heading.where(level: 1): set text(size:16pt, weight: "semibold")
  show heading.where(level: 2): set text(size:14pt,weight:"semibold")
  show heading.where(level: 3): set text(size:12pt,weight:"semibold")
   show heading.where(level: 4): set text(size:12pt,weight: "regular",style: "italic")

  show heading.where(level: 1, numbering: "1.1"): it => {
    pagebreak() //pagebreak(weak: true)
    it
  }
  // Reference first-level headings as "Abschnitt"
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      [Abschnitt ]
      numbering(
        el.numbering,
        ..counter(heading).at(el.location())
      )
    } else {
      it
    }
  }

  // --- Footer ---
  set  footnote.entry(indent: 0em, clearance: 1em)
  // --- Paragraphs ---
  set par(leading: 1em)

  // --- Citations ---
  set cite(style: "../literature/my_ieee.csl")//"ieee")
  //"institute-of-electrical-and-electronics-engineers")

  // --- Figures ---
  show figure.where(kind: image): pic => {
    //set text(size: 0.85em)
    pic
    //rect(pic)
  }
    
  // --- Table of Contents ---
  show outline.entry.where(level: 1): it => {
    //if outline.entry != image and it.kind != table{
      show: strong
      v(1pt, weak: false)
      let params = it.fields()
      //if-condition to prevent recursion
      if it.fill != none {
        let params = it.fields()
        params.fill = none
        outline.entry(..params.values())
      } else {
        it
      }
    //}
  }
  //heading(numbering: none)[Inhaltsverzeichnis]
  outline(
    title: "Inhaltsverzeichnis",
    fill: repeat([.]+h(0.5em)),
    indent: auto
  )
  
  
  //v(2.4fr)

  //List of acronyms
  pagebreak()
  heading(numbering: none)[Abkürzungsverzeichnis]
  locate(loc => usedAcronyms.final(loc)
    .pairs()
    .filter(x => x.last())
    .map(pair => pair.first())
    .sorted()
    .map(key => grid(
        columns: (auto, auto, auto),
        gutter: 0em,
      strong(key),repeat([.]),acronyms.at(key) 
      )).join())

  // List of figures.
  pagebreak();

//   show outline.entry: it => {
//   if it.at("label", default: none) == <modified-entry> {
//     it // prevent infinite recursion
//   } else {
//     let caption = it.body
//     let elem-label = it.element.at("label", default: none)
//     if elem-label != none {
//       let caption-label = label(repr(elem-label).slice(1, -1) + "-caption")
//       caption = locate(loc => {
//         let q = query(selector(metadata).and(selector(caption-label)), loc)
//         if q.len() > 0 {
//           let short-caption = q.first().value
//           let figure-number = numbering("1", ..it.element.counter.at(it.element.caption.location))
//           [#it.element.supplement #figure-number: #short-caption]
//         } else {
//           it.body
//         }
//       })
//     }
//     [#outline.entry(
//         it.level,
//         it.element,
//         caption,
//         it.fill,
//         it.page,
//       ) <modified-entry>
//     ]
//   }
// }

  heading(numbering: none)[Abbildungsverzeichnis]
  outline(
    title: none,
    //fill: repeat([.]),
    target: figure.where(kind: image)
  )
  //command for acronym package
  //print-index()
  //command for second variant
  //print_acronym_listing("")

  // List of tables.
  pagebreak()
  heading(numbering: none)[Tabellenverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: table)
  )

  //pagebreak()

  // Main body.
  set par(justify: true, leading: 1em, linebreaks: "optimized" /*first-line-indent: 2em*/)
  // show par: p => {
  //   set par(leading: 1.15em,justify: true)
  //   text(p)
  //   v(1em)
  // }
  set page(numbering: "1")
  counter(page).update(1) 

  body

  // Appendix.
  pagebreak()
  heading(numbering: none)[Anhang A: Supplementary Material]
  include("../common/appendix.typ")

  pagebreak()
  heading(numbering: none)[Literaturverzeichnis]
  bibliography("../literature/literature.bib", title: none)//, style: "../literature/my_ieee.csl")
  
  //Selbstständigkeitserklärung
  set page(numbering: none)
  heading(numbering: none)[Selbstständigkeitserklärung]
  [Ich versichere, dass ich die Masterarbeit selbständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe.]
  v(3cm)
  table(
    stroke: none,
    inset: 0pt,
    row-gutter: 10pt,
    columns: (1fr,1fr,1fr),
    align: (x,y) => (left,center,right).at(x),
    rows: 2,
    line(length: 100%),
    [],
    line(length: 100%),
    [Datum, Ort],
    [],
    [#author]
  )
}
#let apos(text) = {
    [\"] + text + [\"]
}

#let mark_yellow(text) = {
  box(
    fill: yellow
  )[#text]
}

#let mark_green(text) = {
  box(
    fill: green
  )[#text]
}

#let mark_red(text) = {
  box(
    fill: red
  )[#text]
}

#let placeholder(text) = {
  box(
    rect(
      fill: yellow,
      width: 100%
    )[#text]
  )
} 
