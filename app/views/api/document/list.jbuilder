json.array! @documents do |document|
  json.(document, :id, :name, :created_at)
end