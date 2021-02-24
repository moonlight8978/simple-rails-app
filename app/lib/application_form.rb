class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  def invalid?
    !valid?
  end
end
