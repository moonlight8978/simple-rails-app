class Csvs::Export::Rows::Note < Csvs::ApplicationExportRow
  column :title, header: "Title", no: 1
  column :content, header: "Content", no: 2
  column :important, header: "Important", no: 3
  column :created_at, header: "Created at", no: 4
end
