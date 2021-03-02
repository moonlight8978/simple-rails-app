FactoryBot.define do
  factory :form_sudo, class: Forms::Sudo do
    key { "notifications/edit" }
    model { create(:user) }
    return_to { "/notifications/edit" }
    password { "123456" }
  end
end
