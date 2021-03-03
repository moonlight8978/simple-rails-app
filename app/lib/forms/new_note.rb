class Forms::NewNote < ApplicationForm
  field :title, type: :string
  field :content, type: :string
  field :important, type: :boolean
  field :created_at, type: :date
  field :user

  validates :title, presence: true, length: { maximum: 10 }
  validates :content, presence: true, length: { maximum: 3000 }
  validates :important, presence: true

  def save_model
    Note.create(attributes)
    true
  end
end
