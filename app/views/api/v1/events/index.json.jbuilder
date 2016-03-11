json.array! @events do |event|
  json.id              event.id
  json.name            event.name
  json.location_name   event.location_name
  json.image           event.image.url("#{event.image_mode}_small_thumb")
  json.duration        event.duration
end
