require 'csv'

class CsvDocument < Document
  
  MIME_TYPES = ['text/csv']
  ENCODINGS = ['UTF-8', 'ISO8859-1']
  
  def columns
    header_line? ? csv_content.headers : generic_columns
  end
  
  def rows
    @rows ||= begin
      csv_content.map do |line|
        {}.tap do |line_hash|
          columns.each_with_index do |column_name, index|
            line_hash[column_name] = line[index]
          end
        end
      end
    end
  end

  #private
  
  def generic_columns
    [].tap do |columns|
      max_columns_no.times do |i|
        columns << "Column #{i+1}"
      end
    end
  end
  
  def max_columns_no
    @max_columns_no ||= begin
      csv_content.reduce(0) do |acc, line|
        line.length > acc ? line.length : acc
      end
    end
  end
  
  def column_separator
    case additional_params['column_separator']
      when 'pipe'  then '|'
      when 'tab'   then "\t"
      when 'space' then ' '
      when 'comma' then ','
    end
  end
  
  def row_separator
    case additional_params['row_separator']
      when 'windows' then "\r\n"
      when 'linux'   then "\n"
    end
  end
  
  def string_separator
    case additional_params['string_separator']
      when 'single' then "\'"
      when 'double' then '"'
      when 'none'   then nil
    end
  end
  
  def header_line?
    case additional_params['header_line']
      when 'true' then true
      else false
    end
  end
  
  def encoding
    ENCODINGS.include?(additional_params['encoding']) ? additional_params['encoding'] : nil
  end
    
  def csv_content
    @content ||= CSV.new(file.force_encoding(encoding), csv_options).read
  end
  
  def csv_options
    {}.tap do |options|
      options[:col_sep] = column_separator if column_separator.present?
      options[:row_sep] = row_separator if row_separator.present?
      options[:quote_char] = string_separator if string_separator.present?
      options[:headers] = header_line?
      options[:encoding] = encoding
    end
  
  end
  
end