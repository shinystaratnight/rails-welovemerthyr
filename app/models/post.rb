class Post
  include Mongoid::Document

  STATUSES = %w(draft published)

  field :title, type: String
  field :body, type: String
  field :status, type: String, default: STATUSES[0]
  field :published_date, type: DateTime

  validates_presence_of :title

  before_save :set_published_date, if: ->{ status_changed? && status == STATUSES[1] }

  attr_accessible :title, :body, :status, :published_date

private

  def set_published_date
    self.published_date = Time.zone.now
  end
end
