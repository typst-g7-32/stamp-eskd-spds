#import "src/template.typ": eskd-frame, eskd-tables, frame

#show: eskd-frame.with(
  tables: (
    main-table: eskd-tables.table-dd,
    side-table: eskd-tables.table-left-5r,
  ),
  vertical: true,
)

#lorem(1000)
