class Subscriber
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String
  field :deal_id, type: Integer

  belongs_to :deal

  validates_presence_of :name, :email, :deal_id

  # TODO: voucher scoped?
  validates_uniqueness_of :deal_id, scope: [:name, :email]

  attr_accessible :name, :email, :deal_id

  scope :newest, desc(:created_at)
end
