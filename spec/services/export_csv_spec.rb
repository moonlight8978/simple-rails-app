require 'rails_helper'

RSpec.describe Services::ExportCsv, type: :model do
  let(:definition) { Csvs::Export::Rows::Note }
  let(:iterator) { Csvs::Export::Iterators::Basic.new(definition) }
  let(:user) { create(:user) }
  let!(:notes) { create_list(:note, 2, user: user) }

  subject do
    Array.new.tap { |io| described_class.perform(Note.all, io, iterator, user: user) }.length
  end

  it "generate csv correctly" do
    is_expected.to eq(2)
  end
end
