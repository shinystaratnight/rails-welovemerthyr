class PageTemplate
  include Mongoid::Document
  include Mongoid::Slug

  field :title, type: String
  field :body, type: String

  slug :title

  has_many :pages, inverse_of: :page_template

  validates_presence_of :title

  attr_accessible :title, :body
end
