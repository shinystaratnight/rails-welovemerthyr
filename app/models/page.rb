class Page
  include Mongoid::Document
  include Mongoid::Slug

  STATUSES = []

  field :title, type: String
  field :body, type: String
  field :status, type: String

  slug :title

  belongs_to :parent, class_name: 'Page', foreign_key: 'parent_id', inverse_of: :page
  has_many :children, class_name: 'Page', inverse_of: :page
  belongs_to :page_template, inverse_of: :page

  validates_presence_of :title

  attr_accessible :title, :body, :page_template_id, :status, :parent_id
end
