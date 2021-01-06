json.extract! post, :id, :my_thread_id, :content, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
