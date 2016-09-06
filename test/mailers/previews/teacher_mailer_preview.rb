# Preview all emails at http://localhost:3000/rails/mailers/teacher_mailer
class TeacherMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/teacher_mailer/password_reset
  def password_reset
    teacher = Teacher.first
    teacher.reset_token = Teacher.new_token
    TeacherMailer.password_reset(teacher)
  end
end
