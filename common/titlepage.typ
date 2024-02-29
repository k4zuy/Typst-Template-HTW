#let titlepage(
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
) = {
  set document(title: title, author: author)
  set page(
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  let body-font = "Times New Roman"
  let sans-font = "Times New Roman" //"New Computer Modern Sans"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "de"
  )

  set par(leading: 1em)
  
  // --- Title Page ---
  //v(1cm)
  align(center, image("../images/HTWD_logo_RGB_vertical_color.svg", width: 50%))
  //align(center, image("../images/HTWD_logo_RGB_vertical_color.svg", width: 50%)) //26%

  v(5mm)
  align(center, text(font: sans-font, 2em, weight: 700, "Abschlussarbeit"))
  
  /*
  v(5mm)
  align(center, text(font: sans-font, 1.5em, weight: 100, "School of Computation, Information and Technology \n -- Informatics --"))

  v(15mm)

  align(center, text(font: sans-font, 1.3em, weight: 100, degree + "’s Thesis in " + program))
  v(8mm)
  */

  //english title
  //align(center, text(font: sans-font, 2em, weight: 700, title))
  
  
  align(center, text(font: sans-font, 2em, weight: 500, titleGerman))
  
  pad(
    top: 3em,
    right: 10%,
    left: 25%,
    grid(
      columns: 2,
      //gutter: 1em,
      row-gutter: 1em,
      column-gutter: 6em,
      strong("Autor: "), author,
      strong("Matrikelnummer: "), studentNumber, 
      strong("Studiengang: "), program,
      strong("Gutachter: "), supervisor,
      strong("Zweitgutachter: "), advisors.join(", "),
      strong("Ausgabedatum: "), startDate,
      strong("Abgabedatum: "), submissionDate,
    )
  )

  pagebreak()
}