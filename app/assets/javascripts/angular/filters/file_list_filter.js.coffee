@csvv.filter 'FileListFilter', ()->
  (files, selected_name)->
    if selected_name?
      if files? && files.length > 0
        result = []
        for file in files
          if file.name.includes(selected_name)
            result.push file
        return result
    else
      return files