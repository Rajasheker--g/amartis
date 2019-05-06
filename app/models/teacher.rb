class Teacher
  include Mongoid::Document

  field :emp_id, type: Integer
  field :first_name, type: String
  field :middle_name, type: String
  field :last_name, type: String
  field :dob, type: Date
  field :age, type: Integer
  field :class_name, type: String
  field :ph_no, type: String
  field :email, type: String

  belongs_to :organisation
  has_many :students
  scope :teachers_list, -> { where(:first_name.ne => "", :first_name.exists => true) }

  def full_name_and_class_name
    "#{first_name} - #{last_name} - #{class_name}"
  end
end
