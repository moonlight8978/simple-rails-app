class Csvs::Import::Note < ApplicationImportCsv
  model Note

  column :title, type: :string, no: 1
  column :content, type: :string, no: 2
  column :important, type: :string, no: 3
  column :created_at, type: :string, no: 4, default: -> { Time.current.to_s }

  virtual :user
end
