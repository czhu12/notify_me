class AlertMailer < ActionMailer::Base
  include SendGrid
  default from: "no-reply@utiquelearn.com"
  layout 'mailer'

  def send_alert(alert, opts)
    @alert = alert

    mail(to: opts[:to], subject: opts[:subject])
  end
end
