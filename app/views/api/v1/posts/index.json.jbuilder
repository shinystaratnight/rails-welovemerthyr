json.array! @posts do |post|
  json.id                 post.id
  json.published_at       post.published_at
  json.title              post.title
  json.category           post.category
  json.image              post.image.url("#{post.image_mode}_big_thumb")
end
