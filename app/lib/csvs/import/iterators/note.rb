class Csvs::Import::Iterators::Note
  attr_accessor :user

  def initialize(user)
    self.user = user
  end

  def errors
    @errors ||= []
  end

  def call(row)
    csv = Csvs::Import::Rows::Note.parse(row)
    note_form = Forms::NewNote.new(**csv.attributes, user: user)
    is_csv_valid = csv.valid?
    is_note_saved = note_form.save
    unless is_csv_valid && is_note_saved
      csv.errors.merge!(note_form.errors)
      errors.concat(csv.error_messages)
    end
  end
end
