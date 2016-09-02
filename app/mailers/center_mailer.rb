class CenterMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.center_mailer.password_reset.subject
  #

  def password_reset(center)
    @center = center
    mail to: center.email, subject: "Password reset"
  end
end
