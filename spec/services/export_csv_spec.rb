require 'rails_helper'

RSpec.describe Services::ExportCsv, type: :model do
  let(:definition) { Csvs::Export::Rows::Note }
  let(:iterator) { Csvs::Export::Iterators::Basic.new(Note.all, definition) }
  let(:user) { create(:user) }

  before do
    create(:note, title: "Title 1", content: "Content 1", important: true, created_at: Time.zone.local(2021, 1, 2), user: user)
    create(:note, title: "Title 2", content: "Content 2", important: false, created_at: Time.zone.local(2021, 1, 1), user: user)
  end

  subject do
    Array.new.tap { |io| described_class.new(io).perform(iterator, headers: definition.generate_headers_line) }.join
  end

  it "generate csv correctly" do
    result = <<-CSV.strip_heredoc
      Title,Content,Important,Created at
      Title 1,Content 1,1,2021-01-02
      Title 2,Content 2,0,2021-01-01
    CSV
    is_expected.to eq(result)
  end
end
