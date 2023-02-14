class Tomorecipe < ApplicationRecord
    belongs_to :user
    mount_uploader :image, ImageUploader
    mount_uploader :image2, ImageUploader
    mount_uploader :image3, ImageUploader
    mount_uploader :image4, ImageUploader
    mount_uploader :video, VideoUploader
    has_many :tag_maps, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :tags, through: :tag_maps
    has_many :liked_users, through: :likes, source: :user
    validates :title, presence: true

    def save_tag(sent_tags)
        current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
        old_tags = current_tags - sent_tags
        new_tags = sent_tags - current_tags
   
        old_tags.each do |old|
          self.tags.delete Tag.find_by(tag_name: old)
        end
   
        new_tags.each do |new|
          new_tomorecipe_tag = Tag.find_or_create_by(tag_name: new)
          self.tags << new_tomorecipe_tag
        end
    end
end
