class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  mount_uploader :picture, PictureUploader
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  private

    # 验证上传的图像大小
    def picture_size
      if picture.size > 1.megabytes
        errors.add(:picture, "should be less than 1MB")
      end
    end  
end
