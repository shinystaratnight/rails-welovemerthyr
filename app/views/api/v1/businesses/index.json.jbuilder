json.array! @businesses do |business|
  json.id                   business.id
  json.name                 business.name
  json.category             business.category
  json.address              business.address
  json.town                 business.town
  json.postcode             business.postcode
  json.telephone            business.telephone
  json.website              business.website
  json.photo                image_absolute_url(business.photo.url(:small_thumb))
end
