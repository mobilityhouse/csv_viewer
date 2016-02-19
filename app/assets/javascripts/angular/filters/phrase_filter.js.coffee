@csvv.filter 'PhraseFilter', ()->
  (table_rows, search_phrase, selected_columns, scope)->
    console.log "Search: #{search_phrase}"
    if search_phrase?
      filtered_rows = []
      for row in table_rows
        fields = if selected_columns?.length > 0
          selected_columns
        else
          _.without(Object.keys(row), '$$hashKey')
        for field in fields
          if row[field]?.includes(search_phrase)
            filtered_rows.push(row)
            break
      scope.rows_count = filtered_rows.length
      return filtered_rows
    else
      scope.rows_count = table_rows?.length
      return table_rows
