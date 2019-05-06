class Address
  include Mongoid::Document
  field :h_no, type: String
  field :street, type: String
  field :landmark, type: String
  field :village, type: String
  field :mandle, type: String
  field :city, type: String
  field :state, type: String
  field :country, type: String
  field :pincode, type: String

  belongs_to :addressable, polymorphic: true
end
