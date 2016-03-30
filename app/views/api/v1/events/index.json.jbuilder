json.array! @events do |event|
  json.id              event.id
  json.name            event.name
  json.location_name   event.location_name
  json.image           image_absolute_url(event.image.url("#{event.image_mode}_small_thumb"))
  json.next_occurrence event.next_occurrence
end
