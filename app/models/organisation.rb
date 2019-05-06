class Organisation
  include Mongoid::Document
  
  field :org_name, type: String
  field :org_code, type: String

  has_many :teachers
  
  has_one :address, as: :addressable
  accepts_nested_attributes_for :address
end
