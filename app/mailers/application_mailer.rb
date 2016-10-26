class ApplicationMailer < ActionMailer::Base
  default from: "password-reset@guidestar-attendance.com"
  layout 'mailer'
end
