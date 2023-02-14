class TagMap < ApplicationRecord
  belongs_to :tomorecipe
  belongs_to :tag

  validates :tomorecipe_id, presence: true
  validates :tag_id, presence: true
end
