class Forms::EditProfile < ApplicationForm
  attribute :username, :string
  untyped_attribute :avatar

  validate :avatar_must_be_in_correct_format
  validate :username_must_be_unique

  private

  # TODO: Extract into validators
  def username_must_be_unique
    errors.add(:username, :taken) if username.present? && User.where(username: username).where.not(id: model.id).exists?
  end

  # TODO: Extract into validators
  def avatar_must_be_in_correct_format
    return unless avatar.present?

    # FileMagic.mime { |fm| fm.file(avatar.path) }
    valid_format = ["image/png", "image/jpg", "image/jpeg"].include?(avatar.content_type) && ["image/png", "image/jpg", "image/jpeg"].include?(MimeMagic.by_magic(avatar)&.type)
    errors.add(:avatar, :content_type_invalid) unless valid_format

    valid_size = avatar.size <= 2.megabytes
    errors.add(:avatar, :file_size_out_of_range, filesize: avatar.size) unless valid_size
  end
end
