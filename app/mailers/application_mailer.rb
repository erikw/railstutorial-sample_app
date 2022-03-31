class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@example.com' # TODO change for email in production
  layout 'mailer'
end
