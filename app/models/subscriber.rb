class Subscriber
  include Mongoid::Document
  include Mongoid::Timestamps

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :mobile, type: String
  field :address, type: String
  field :postcode, type: String
  field :deal_id, type: Integer

  belongs_to :deal

  validates_presence_of :first_name, :last_name, :email, :address, :postcode, :deal_id

  # TODO: voucher scoped?
  validates_uniqueness_of :deal_id, scope: [:first_name, :email]

  attr_accessible :first_name, :last_name, :email, :mobile, :address, :postcode, :deal_id

  scope :newest, desc(:created_at)
end