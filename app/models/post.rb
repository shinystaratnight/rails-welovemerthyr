class Post
  include Mongoid::Document
  include Mongoid::Slug

  STATUSES = %w(draft published)

  field :title, type: String
  field :body, type: String
  field :status, type: String, default: STATUSES[0]
  field :published_date, type: DateTime

  slug :title

  validates_presence_of :title
  validates_inclusion_of :status, in: STATUSES

  before_save :set_published_date, if: ->{ status_changed? && status == STATUSES[1] }

  attr_accessible :title, :body, :status, :published_date

private

  def set_published_date
    self.published_date = Time.zone.now
  end
end
