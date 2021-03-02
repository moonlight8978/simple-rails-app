require 'rails_helper'

RSpec.describe Forms::Sudo, type: :model do
  let(:form) { build(:form_sudo, **attrs) }
  let(:attrs) { {} }

  describe "#session_key" do
    subject { form.session_key }

    let(:attrs) { { key: "notifications/edit" } }

    it "add prefix to prevent overriding session" do
      is_expected.to eq("_password_notifications/edit")
    end
  end

  describe "validations" do
    subject { form }

    context "when password is invalid" do
      let(:attrs) { { password: 'wrong' } }

      it { is_expected.to be_invalid }
    end

    context "when password is valid" do
      let(:attrs) { { password: '123456' } }

      it { is_expected.to be_valid }
    end
  end
end
