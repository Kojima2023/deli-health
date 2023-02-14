class Like < ApplicationRecord
  belongs_to :tomorecipe
  belongs_to :user
  validates_uniqueness_of :tomorecipe_id, scope: :user_id
end
