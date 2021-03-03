class Csvs::Import::Iterators::Note
  attr_accessor :user

  def initialize(user)
    self.user = user
  end

  def errors
    @errors ||= []
  end

  def call(row)
    csv = Csvs::Import::Note.parse(row.data)
    note = user.notes.create(csv.attributes)
    if note.errors.any?
      csv.errors.merge!(note.errors)
      errors << csv.errors.full_messages
    end
  end
end
