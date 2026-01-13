#import "place.typ": place-horizontal, place-vertical
#import "tables-eskd.typ" as eskd-tables
#import "frame.typ": document-frame

#let frame(body) = {
  set page(
    margin: (
      left: 30mm,
      right: 10mm,
      top : 20mm,
      bottom: 20mm,
    ),
    background: document-frame
  )

  body
}

#let eskd-frame(table-type: eskd-tables.table-dd, vertical: true, show-frame: true, body) = context {
  let table-height = measure(table-type).height
  set page(
      margin: (
        left: 30mm,
        right: 10mm,
        top : 20mm,
        bottom: 20mm + table-height,
      ),
      background: if show-frame {document-frame}
    )
  if vertical {
    place-vertical(table-type, body, table-height)
  } else {
    place-horizontal(table-type, body, table-height)
  }
}