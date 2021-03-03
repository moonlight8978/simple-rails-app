require 'rails_helper'

RSpec.describe Services::ImportCsv, type: :model do
  let(:definition) { Csvs::Import::Note }
  let(:user) { create(:user) }
  let(:iterator) { Csvs::Import::Iterators::Note.new(user) }
  let(:csv_file) { file_fixture("sample_book.csv") }

  subject { described_class.perform(csv_file, iterator) }

  it "imports successfully" do
    subject

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
