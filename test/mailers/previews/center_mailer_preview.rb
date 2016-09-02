# Preview all emails at http://localhost:3000/rails/mailers/center_mailer
class CenterMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/center_mailer/password_reset
  def password_reset
    center = Center.first
    center.reset_token = Center.new_token
    CenterMailer.password_reset(center)
  end
end
