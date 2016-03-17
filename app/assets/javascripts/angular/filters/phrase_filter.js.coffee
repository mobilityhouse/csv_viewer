@csvv.filter 'PhraseFilter', ()->
  (table_rows, search_phrase, selected_columns, scope)->
    if search_phrase?
      filtered_rows = []
      for row in table_rows
        fields = if selected_columns?.length > 0
          selected_columns
        else
          _.without(Object.keys(row), '$$hashKey')
        for field in fields
          if (row[field].constructor == String)
            field_text = row[field]
          else
            field_text = $.parseHTML(row[field].toString())[0].innerHTML
          if field_text.includes(search_phrase)
            filtered_rows.push(row)
            break
      scope.rows_count = filtered_rows.length
      return filtered_rows
    else
      scope.rows_count = table_rows?.length
      return table_rows
