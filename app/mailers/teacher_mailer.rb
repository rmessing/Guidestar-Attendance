class TeacherMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.teacher_mailer.password_reset.subject
  #

  def password_reset(teacher)
    @teacher = teacher
    mail to: teacher.email, subject: "Password reset"
  end
end