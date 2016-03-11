json.array! @deals do |deal|
  json.id              deal.id
  json.title           deal.title
  json.business        deal.business_name
  json.end_date        deal.end_date
end
