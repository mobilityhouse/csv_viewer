class DocumentFilter < ApplicationRecord
  
  FILTER_COLUMNS = ['phrase_filter', 'column_filter']
  
  belongs_to :document

  def self.null_filter
    {
      column_filter: [],
      phrase_filter: nil
    }
  end
  
  def to_hash
    FILTER_COLUMNS.reduce({}) do |acc, col|
      acc.tap{ |a| a[col] = send(col) }
    end
  end
  
end
