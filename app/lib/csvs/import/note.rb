class Csvs::Import::Note < ApplicationImportCsv
  model Note

  column :title, type: :string, no: 1
  column :content, type: :string, no: 2
  column :important, type: :boolean, no: 3
  column :created_at, type: :datetime, no: 4

  validates :important, inclusion: ["0", "1"], allow_blank: true
  validate :created_at_must_be_in_datetime_format

  private

  def created_at_must_be_in_datetime_format
    return if created_at.blank?

    errors.add(:created_at, :invalid) unless (Time.zone.parse(created_at) rescue nil)
  end
end
