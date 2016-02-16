@csvv.filter 'PaginationFilter', ()->
  (table_rows, current_page=1, per_page=10)->
    if table_rows?
      start = (current_page - 1) * per_page
      stop = (current_page * per_page)
      return table_rows.slice(start, stop)
    else
      return table_rows
