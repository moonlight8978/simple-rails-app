require 'rails_helper'

RSpec.describe ApplicationImportCsv, type: :model do
  class SampleBookCsv < ApplicationImportCsv
    column :title, :string
    column :author, :string
    column :published_at, :date, default: -> { Date.current.to_s }
    column :sales_volume, :integer

    virtual :publisher
  end


  describe ".parse" do
    subject { SampleBookCsv.parse(row) }

    let(:row) { ["Depzai", "superdepzai", "2020-12-01", "200"] }

    it "returns new csv instance, which has correct data" do
      csv = subject

      expect(csv).to be_a(SampleBookCsv)
      expect(csv.title).to eq("Depzai")
      expect(csv.author).to eq("superdepzai")
      expect(csv.published_at).to eq("2020-12-01")
      expect(csv.sales_volume).to eq("200")
    end
  end

  describe "default values" do
    subject { SampleBookCsv.new }

    around { |e| travel_to(Time.zone.local(2021, 1, 1)) { e.run } }

    it "has default values as string" do
      csv = subject

      expect(csv.published_at).to eq("2021-01-01")
    end
  end

  describe "#attributes" do
    let(:user) { User.new(username: "khoaito") }

    subject do
      csv = SampleBookCsv.new(title: "depzai", author: "depzaivler", published_at: "2020-12-01", sales_volume: "500")
      csv.publisher = user
      ActiveSupport::HashWithIndifferentAccess.new(csv.attributes)
    end

    it "cast data to correct type" do
      is_expected.to include(
        title: "depzai",
        author: "depzaivler",
        published_at: "2020-12-01".to_date,
        sales_volume: 500,
        publisher: user
      )
    end
  end
end
