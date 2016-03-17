@csvv.filter 'PhraseFilter', ()->
  (table_rows, search_phrase, selected_columns, scope)->
    if search_phrase? && table_rows? 
      filtered_rows = []
      for row in table_rows
        fields = if selected_columns?.length > 0
          selected_columns
        else
          _.without(Object.keys(row), '$$hashKey')
        for field in fields
          field_text = row[field] || ''
          if !(field_text.constructor == String)
            field_text = $.parseHTML(field_text.toString())[0].innerHTML
          if field_text.includes(search_phrase)
            filtered_rows.push(row)
            break
      scope.rows_count = filtered_rows.length
      return filtered_rows
    else
      scope.rows_count = table_rows?.length
      return table_rows
