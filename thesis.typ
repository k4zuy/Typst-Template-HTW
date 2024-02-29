#import "common/titlepage.typ": *
#import "common/metadata.typ": *
#import "style/style.typ": *
#import "common/acronyms.typ": acro
//#import "common/acronyms.typ": *

#titlepage(
  title: titleEnglish,
  titleGerman: titleGerman,
  degree: degree,
  program: program,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  studentNumber: studentNumber,
  startDate: startDate,
  submissionDate: submissionDate
)


#show: style.with(
  title: titleEnglish,
  titleGerman: titleGerman,
  degree: degree,
  program: program,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  studentNumber: studentNumber,
  startDate: startDate,
  submissionDate: submissionDate
)

= Einleitung
#lorem(100)