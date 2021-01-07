class Post < ApplicationRecord
  belongs_to :my_thread
  belongs_to :user
  has_rich_text :content
end
