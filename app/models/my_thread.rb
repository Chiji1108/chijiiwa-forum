class MyThread < ApplicationRecord
  belongs_to :user
  has_one_attached :thumbnail
  has_many :posts
  accepts_nested_attributes_for :posts

  validate :thumbnail_type, :thumbnail_size, if: :was_attached?

  private
    def thumbnail_type
      if !thumbnail.blob.content_type.in?(%('image/jpeg image/png'))
        thumbnail.purge
        errors.add(:thumbnail, 'はjpegまたはpng形式でアップロードしてください')
      end
    end

    def thumbnail_size
      if thumbnail.blob.byte_size > 5.megabytes
        thumbnail.purge
        errors.add(:thumbnail, "はファイルサイズを5MB以内にしてください")
      end
    end

    def was_attached?
      self.thumbnail.attached?
    end
end
