#import "place.typ": place-tables
#import "tables-eskd.typ" as eskd-tables
#import "frame.typ": document-frame

#let frame(body) = {
  set page(
    margin: (
      left: 30mm,
      right: 10mm,
      top: 20mm,
      bottom: 20mm,
    ),
    background: document-frame,
  )

  body
}

// для корректного отображения первая таблица массива таблиц должна быть той, что находится снизу таблицы (относительно неё считается высота футера)
#let eskd-frame(
  tables: (
    main-table: eskd-tables.table-dd,
    side-table: eskd-tables.table-left-5r,
  ),
  vertical: true,
  show-frame: true,
  body,
) = context {
  let table-height
  let is-first-page = here().page() == 1

  if (is-first-page) {
    table-height = measure(tables.main-table).height
  }

  set page(
    margin: (
      left: 30mm,
      right: 10mm,
      top: 20mm,
      bottom: 20mm + table-height,
    ),
    background: if show-frame { document-frame },
  )
  
  place-tables(
    tables: tables,
    body,
    is-page-vertical: vertical,
  )
}
