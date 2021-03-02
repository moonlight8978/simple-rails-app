class Note < ApplicationRecord
  belongs_to :user, inverse_of: :notes
end
