json.array! @deals do |deal|
  json.id              deal.id
  json.title           deal.title
  json.description     deal.description
  json.business        deal.business_name
  json.end_date        deal.end_date
  json.image           asset_path(deal.image.url(:thumb))
end
