class Document < ApplicationRecord
  validates :name, :file, :type, presence: true
end
