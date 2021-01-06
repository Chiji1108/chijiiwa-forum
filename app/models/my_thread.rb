class MyThread < ApplicationRecord
  belongs_to :user
  has_one_attached :thumbnail
  has_many :posts
  accepts_nested_attributes_for :posts
end
