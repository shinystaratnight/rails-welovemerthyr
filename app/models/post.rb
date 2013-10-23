class Post
  include Mongoid::Document
  include Mongoid::Slug

  paginates_per 4

  STATUSES = %w(draft published)
  CATEGORIES = ['News', 'Shopping', 'Hints and Tips', 'Bit of a Laugh', 'Events', 'Offers']

  field :title, type: String
  field :body, type: String
  field :status, type: String, default: STATUSES[0]
  field :published_at, type: DateTime
  field :image, type: String
  field :category, type: String

  slug :title

  validates_presence_of :title
  validates_inclusion_of :status, in: STATUSES

  before_save :set_published_at, if: ->{ status_changed? && status == STATUSES[1] }

  attr_accessible :title, :body, :status, :published_at, :image, :remove_image, :category

  mount_uploader :image, PostImageUploader

  scope :latest, ->(limit) { Post.where(status: 'published').desc(:published_at).limit(limit) }

private

  def set_published_at
    self.published_at = Time.zone.now
  end
end
