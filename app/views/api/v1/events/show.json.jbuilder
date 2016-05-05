json.name                @event.name
json.description         @event.description
json.location_name       @event.location_name
json.location_address    @event.location_address
json.coordinates         @event.coordinates
json.next_occurrence     @event.next_occurrence
#json.starts              @event.starts.strftime("%b #{@event.starts.day.ordinalize}, %-I:%M%P")
#json.ends                @event.ends.strftime("%b #{@event.ends.day.ordinalize}, %-I:%M%P")
json.date_info           render_date(@event)
json.duration            @event.duration
json.small_image         @event.image.url("#{@event.image_mode}_small_thumb")
json.big_image           @event.image.url("#{@event.image_mode}_big_thumb")
