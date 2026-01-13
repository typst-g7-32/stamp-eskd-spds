#let border-params = context {
  // FIXME: https://github.com/typst/typst/issues/7179
  let (width, height) = if page.flipped { (page.height, page.width) } else { (page.width, page.height) }
  rect(
      width: width - 5mm - 20mm,
      height: height - 10mm - 5mm,
      stroke: 0.5mm + black,
    )
}

#let document-frame = context {
  place(
    right+bottom,
    dx: -5mm,
    dy: -10mm,
    border-params
  )
}
