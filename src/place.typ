#import "tables-eskd.typ" as eskd-tables
#import "tables-spds.typ" as spds-tables

// "сборник" отступов футера для всех типов таблиц (для служебного пользования)
#let __get-footer-descent-by-table-type(table-type: eskd-tables) = {
  let footer-descent = 0pt

  if (table-type == eskd-tables.table-dd) {
    footer-descent = 0pt
  }
  if (table-type == eskd-tables.table-tdd-f) {
    footer-descent = 85pt
  }
  if (table-type == eskd-tables.table-tdd-s) {
    footer-descent = 132pt
  }
  if (table-type == eskd-tables.table-tdd-s-d) {
    footer-descent = 132pt
  }

  return footer-descent
}

// "Cборник" отступов футера для всех типов таблиц (для служебного пользования).\
// Расстояния для "главных" таблиц рассчитаны относительно \"right + bottom\" выравнивания . \
// Расстояния для "боковых" таблиц рассчитаны относительно \"left + bottom\" выравнивания . \
// Возвращает словарь со значениями относительных x, y координат.
#let __get-position-by-table-type(table-type: eskd-tables, table-height, is-page-vertical: bool) = {
  let x-position = 0pt
  let y-position = 0pt

  // для боковых таблиц значения универсальны как для альбомной ориентации, так и для книжной
  if (
    table-type == eskd-tables.table-left-3r or table-type == eskd-tables.table-left-5r
  ) {
    x-position = -62.5pt
    y-position = -28.3pt
  }
  // вычисляем положение в случае, если переданная таблица "основная"
  if (
    table-type == eskd-tables.table-dd
      or table-type == eskd-tables.table-tdd-f
      or table-type == eskd-tables.table-tdd-s
      or table-type == eskd-tables.table-tdd-s-d
  ) {
    // для альбомной и книжной ориентации значения по x будут различаться
    if (is-page-vertical) {
      x-position = -28.3pt
    } else {
      x-position = 14pt
    }
    y-position = -45mm + table-height / 1.5
  }

  return (x: x-position, y: y-position)
}

#let place-tables(
  tables: (
    main-table: eskd-tables.table-dd,
    side-table: eskd-tables.table-left-5r,
  ),
  body,
  is-page-vertical: true,
) = {
  // получаем относительное положение таблиц
  let relative-main-table-position
  let relative-side-table-position

  // получаем позицию нижней (основной) таблицы для первого листа
  if ("main-table" in tables.keys()) {
    relative-main-table-position = __get-position-by-table-type(
      table-type: tables.main-table,
      measure(tables.main-table).height,
      is-page-vertical: is-page-vertical,
    )
  }

  // получаем позицию боковой (побочной) таблицы для всех листов
  if ("side-table" in tables.keys()) {
    // получаем относительное положение таблицы
    relative-side-table-position = __get-position-by-table-type(
      table-type: tables.side-table,
      measure(tables.side-table).height,
      is-page-vertical: is-page-vertical,
    )
  }

  // Указываем поворот страницы
  set page(
    flipped: not is-page-vertical,
    // пытаемся отобразить обе таблицы, если какая-то из них none, то просто "отображается" пустота \
    footer: place(
      bottom + right,
      tables.main-table,
      dx: relative-main-table-position.x,
      dy: relative-main-table-position.y,
    )
      + place(
        bottom + left,
        tables.side-table,
        dx: relative-side-table-position.x,
        dy: relative-side-table-position.y,
      ),
    footer-descent: __get-footer-descent-by-table-type(table-type: tables.main-table),
  )
  body
}