module EventsHelper
  def event_infowindow(e)
    info = ""

    info << "<b>#{e.name}</b>"
    info << "<br />"
    info << "#{e.location_name} - #{e.location_address}"

    info
  end
end
