@csvv.factory 'DropzoneService', ()->
  
  class NgDropZone

    constructor: (@params)->
      @dropzone_el = @params.dropzone_element_id
      @spinner_el = @params.spinner_element_id
      @description_el = @params.description_element_id
      @dropzone = new Dropzone("div##{@dropzone_el}", { url: "/document", createImageThumbnails: false, acceptedFiles: '.csv', previewTemplate: '<div id="preview-template" style="display: none;"></div>'})
      @spinner = new Spinner(@params.spinner_params)
      
      @dropzone.on 'sending', (file, xhr, formData)=>
        $("##{@description_el}").toggle()
        @spinner.spin(document.getElementById(@spinner_el))
        formData.append 'type', @params.type
        formData.append 'name', @params.file_params.name || file.name
        formData.append 'additional_params', JSON.stringify(
          column_separator: @params.file_params.column_separator
          row_separator: @params.file_params.row_separator
          string_separator: @params.file_params.string_separator
          header_line: @params.file_params.header_line
          encoding: @params.file_params.encoding
        )
        
      @dropzone.on 'complete', (upload_params)=>
        if upload_params.status == 'success'
          response_params = JSON.parse(upload_params.xhr.response)
          $('#file_uploader_dz_alert').append("<div class='alert alert-success alert-dismissible' role='alert'>
                                                  <button class='close' type='button' data-dismiss='alert'>
                                                    <i class='fa fa-minus-circle'></i>
                                                  </button>
                                                  <strong>
                                                    File #{response_params.created_file} uploaded successfully
                                                  </strong>
                                               </div>")
        if upload_params.status == 'error'
          $('#file_uploader_dz_alert').append("<div class='alert alert-danger alert-dismissible' role='alert'>
                                          <button class='close' type='button' data-dismiss='alert'>
                                            <i class='fa fa-minus-circle'></i>
                                          </button>
                                          <strong>
                                            Uplading of file unsuccessfull. Please check file settings and try again.
                                          </strong>
                                       </div>")
        @spinner.stop()
        $("##{@description_el}").toggle()