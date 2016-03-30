module ApplicationHelper
  def image_absolute_url url
    "#{request.protocol}#{request.host_with_port}#{url}"
  end
end
