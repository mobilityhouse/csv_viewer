@csvv.filter 'ColumnFilter', ()->
  (all_columns, selected_columns)->
    if selected_columns? && selected_columns.length > 0
      return selected_columns
    else
      return all_columns