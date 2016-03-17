@csvv.filter 'S3Filter', ['$sce',($sce)->
  (rows, extension_type, extension_settings)->
    return if !rows? || !extension_type? || !extension_settings?
    return rows if extension_type != 'S3' || !extension_settings.columns?
    _.each extension_settings.columns, (column)->
      _.each rows, (row)->
        #row[column] = $sce.trustAsHtml("<a href='aaa' ng-click='aaa()'>bbb</a>")
        row[column] = $sce.trustAsHtml("<button ng-click='aaa()'>bbb</button>")
        #row[column] = "<button ng-click='aaa()'>bbb</button>"
    rows
]