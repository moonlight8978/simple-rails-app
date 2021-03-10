require 'rails_helper'

RSpec.describe Services::ImportCsv, type: :model do
  let(:definition) { Csvs::Import::Rows::Note }
  let(:user) { create(:user) }
  let(:iterator) { Csvs::Import::RowProcessors::Note.new(user) }

  subject { described_class.perform(csv_file, iterator) }

  context "when import success" do
    let(:csv_file) { file_fixture("sample_book.csv") }

    it "creates new records" do
      subject

      expect(Note.count).to eq(2)

      new_note1, new_note2 = Note.all

      expect(new_note1.user).to eq(user)
      expect(new_note1.title).to eq("Depzai")
      expect(new_note1.content).to eq("superdepzai")
      expect(new_note1.important).to eq(false)
      expect(new_note1.created_at).to eq(Time.zone.parse("2020-12-01"))

      expect(new_note2.user).to eq(user)
      expect(new_note2.title).to eq("Hello")
      expect(new_note2.content).to eq("wtf")
      expect(new_note2.important).to eq(true)
      expect(new_note2.created_at).to eq(Time.zone.parse("2020-12-15"))
    end
  end

  context "when import failed" do
    let(:csv_file) { file_fixture("sample_invalid_books.csv") }

    it "does not create new records and raises errors" do
      error =
        begin
          subject
        rescue StandardError => e
          e.message
        end

      expect(Note.count).to eq(0)
      expect(error).to eq("Row 1: Title can't be blank\nRow 2: Important is not included in the list\nRow 2: Created at is invalid")
    end
  end
end
