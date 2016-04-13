json.events @events do |event|
  json.id                  event.id
  json._id                 event.id
  json.name                event.name
  json.description         event.description
  json.location_name       event.location_name
  json.location_address    event.location_address
  json.coordinates         event.coordinates
  json.starts              event.starts.strftime("%b #{event.starts.day.ordinalize}, %-I:%M%P")
  json.ends                event.ends.strftime("%b #{event.ends.day.ordinalize}, %-I:%M%P")
  json.next_occurrence     event.next_occurrence
  json.duration            event.duration
  json.small_image         event.image.url("#{event.image_mode}_small_thumb")
  json.big_image           event.image.url("#{event.image_mode}_big_thumb")
  json.updated_at          event.updated_at
end
json.current_time    Time.now.utc
