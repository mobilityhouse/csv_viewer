@csvv.factory 'DropzoneService', ()->
  
  class NgDropZone

    constructor: (@type, @element_id, @file_list)->
      @dropzone = new Dropzone("div##{@element_id}", { url: "/document", createImageThumbnails: false, acceptedFiles: '.csv', previewTemplate: '<div id="preview-template" style="display: none;"></div>'})
      @new_document = {}
      
      @dropzone.on 'sending', (file, xhr, formData)=>
        formData.append 'type', @type
        formData.append 'name', @new_document.name
        formData.append 'additional_params', JSON.stringify(
          column_separator: @new_document.column_separator
          row_separator: @new_document.row_separator
          string_separator: @new_document.string_separator
          header_line: @new_document.header_line
          encoding: @new_document.encoding
        )
        
      @dropzone.on 'complete', ()=>
        @file_list.get_file_list()
        console.log 'finish'