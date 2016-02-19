@csvv.factory 'DropzoneService', ()->
  
  class NgDropZone

    constructor: (@params)->
      @dropzone = new Dropzone("div##{@params.dropzone_element_id}", { url: "/document", createImageThumbnails: false, acceptedFiles: '.csv', previewTemplate: '<div id="preview-template" style="display: none;"></div>'})
      
      @dropzone.on 'sending', (file, xhr, formData)=>
        formData.append 'type', @params.type
        formData.append 'name', @params.file_params.name
        formData.append 'additional_params', JSON.stringify(
          column_separator: @params.file_params.column_separator
          row_separator: @params.file_params.row_separator
          string_separator: @params.file_params.string_separator
          header_line: @params.file_params.header_line
          encoding: @params.file_params.encoding
        )
        
      @dropzone.on 'complete', ()=>
        console.log 'finish'