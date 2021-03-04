class Csvs::Export::Rows::Note < Csvs::ApplicationExportRow
  column :title, header: "Title", no: 1
  column :content, header: "Content", no: 2
  column :important, header: "Important", format_with: :boolean, no: 3
  column :created_at, header: "Created at", format_with: :date, no: 4
end
