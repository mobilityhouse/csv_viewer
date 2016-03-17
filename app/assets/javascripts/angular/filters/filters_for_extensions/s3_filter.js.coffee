@csvv.filter 'S3Filter', ['$sce',($sce)->
  (rows, extension_type, extension_settings)->
    return if !rows? || !extension_type? || !extension_settings?
    return rows if extension_type != 'S3' || !extension_settings.columns?
    _.each extension_settings.columns, (column)->
      _.each rows, (row)->
        if row[column].constructor == String
          row[column] = $sce.trustAsHtml(row[column])
    rows

]