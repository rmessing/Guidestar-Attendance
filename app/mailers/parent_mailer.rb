class ParentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.parent_mailer.password_reset.subject
  #

  def password_reset(parent)
    @parent = parent
    mail to: parent.email, subject: "Password reset"
  end
end