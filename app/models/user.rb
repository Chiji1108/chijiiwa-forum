class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :my_threads, dependent: :destroy
  has_one_attached :avatar

  validate :avatar_type, :avatar_size, if: :was_attached?

  private
    def avatar_type
      if !avatar.blob.content_type.in?(%('image/jpeg image/png'))
        avatar.purge
        errors.add(:avatar, 'はjpegまたはpng形式でアップロードしてください')
      end
    end

    def avatar_size
      if avatar.blob.byte_size > 5.megabytes
        avatar.purge
        errors.add(:avatar, "はファイルサイズを5MB以内にしてください")
      end
    end

    def was_attached?
      self.avatar.attached?
    end
end
