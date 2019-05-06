class StudentMailer < ApplicationMailer
    def student_email(student)
        @student = student
        @url  = "http://example.com/login"
        mail(from: "amaraatis@admin.com", :to => "ljasti@innominds.com", :subject => "Welcome to My Awesome Site")
    end
end
