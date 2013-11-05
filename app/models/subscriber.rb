class Subscriber
  include Mongoid::Document

  field :name, type: String
  field :email, type: String

  validates_presence_of :name, :email

  # TODO: voucher scoped?
  #validates_uniqueness_of :email

  attr_accessible :name, :email
end
