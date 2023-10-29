#import "stateful.typ": *
#import "constants.typ": *

#let ChemRegex = "(\(?((" + elements.map(it=>{"("+it+")"}).join("|") + ")+\d?)+(\)\d*)?(\d*([\+-]\W)?)*)"
#let chem-style = (body) => {
  // Chemical short hands
  show regex("\([EZRSDL]\)"): (it) => {
    if-state-enabled( it , {
      show regex("\w"): text.with(style:"italic")
      it
    } )
  }

  show regex("(((iso)|(sec)|(tert)|(cis)|(trans)|[iompnN])-)|(N,)"): (it) => {
    if-state-enabled( it , {
      show "-": "–"
      emph(it)
    })
  }

  // Chemical Formulae
  show regex(ChemRegex): (it) => {
    if-state-enabled( it , {
      show regex("\d"): sub
      show regex("\d*[+-]"): super
      it
    })
  }
  body
}
