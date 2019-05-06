class Student
  include Mongoid::Document

  field :roll_no, type: Integer
  field :first_name, type: String
  field :middle_name, type: String
  field :last_name, type: String
  field :dob, type: Date
  field :age, type: Integer
  # field :class_name, type: String
  field :teacher_id, type: Integer
  field :parent_id, type: Integer

  belongs_to :parent
  belongs_to :teacher
end