class Parent
  include Mongoid::Document
  # include Addressable
  # require 'concerns/addressable'
  field :first_name, type: String
  field :middle_name, type: String
  field :last_name, type: String
  field :age, type: Integer
  field :ph_no, type: String
  field :govt_proof, type: String

  has_many :students
  has_one :address, as: :addressable
  accepts_nested_attributes_for :address
end
