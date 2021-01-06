class Post < ApplicationRecord
  belongs_to :my_thread
  belongs_to :user
end
