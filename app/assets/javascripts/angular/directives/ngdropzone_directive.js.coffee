@csvv.directive 'ngdropzone', [ '$rootScope', ($rootScope)->

  alert = (message)->
    $('#dz_alert').append(" <div class='alert alert-danger alert-dismissible' role='alert'>
                              <button class='close' type='button' data-dismiss='alert'>
                                <i class='fa fa-minus-circle'></i>
                              </button>
                              <strong>
                                #{message}
                              </strong>
                            </div>")
                            
  info = (message)->
    $('#dz_alert').append(" <div class='alert alert-success alert-dismissible' role='alert'>
                              <button class='close' type='button' data-dismiss='alert'>
                                <i class='fa fa-minus-circle'></i>
                              </button>
                              <strong>
                                #{message}
                              </strong>
                            </div>")

  show_upload_status = (upload_params, stop_callback)->
    stop_callback()
    if upload_params.status == 'success'
      response_params = JSON.parse(upload_params.xhr.response)
      info("File #{response_params.created_file_name} uploaded successfully")
      return response_params.created_file_id
    if upload_params.status == 'error'
      if upload_params.xhr.status == 401
        alert('You are not authorized to upload files')
      else
        alert('Uplading of file unsuccessfull. Please check file settings and try again.')
      return 0
                              
                              
  add_file_params = (file, xhr, formData, file_params, extension_params, start_callback)->
    start_callback()
    formData.append 'type', file_params.type
    formData.append 'name', file_params.name || file.name
    formData.append 'additional_params', JSON.stringify(
      column_separator: file_params.column_separator
      row_separator: file_params.row_separator
      string_separator: file_params.string_separator
      header_line: file_params.header_line
      encoding: file_params.encoding
      extension: file_params.extension)
    if file_params.extension?
      formData.append 'extension_params', JSON.stringify(extension_params)

  return {
    restrict: 'E'
    scope:
      fileParams: '='
      extensionParams: '='
      currentFileId: '='
      onStart: '&'
      onEnd: '&'
    link: (scope, element, attrs)->
      scope.dzName = attrs.dzName
      scope.faIcon = attrs.faIcon
      scope.text = attrs.text
      
      scope.$watch ()->
        $("##{attrs.dzName}").length > 0
      ,()->
        scope.dz = new Dropzone("##{attrs.dzName}", scope.$eval(attrs.dzOptions))
        scope.dz.on 'sending', (file, xhr, formData)->
          add_file_params(file, xhr, formData, scope.fileParams, scope.extensionParams, scope.onStart())
        scope.dz.on 'complete', (upload_params)->
          scope.currentFileId = show_upload_status(upload_params, scope.onEnd())
          _.defer ()->
            scope.$apply()
        
    templateUrl: 'directives/ngdropzone.html'
  }
  
]