json.extract! student, :id, :roll_no, :first_name, :middle_name, :last_name, :dob, :age, :parent_id, :teacher_id, :address_id, :created_at, :updated_at
json.url student_url(student, format: :json)
