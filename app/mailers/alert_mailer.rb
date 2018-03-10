class AlertMailer < ActionMailer::Base
  include SendGrid
  default from: "support@notifyme.com"
  layout 'mailer'

  def send_alert(alert, opts)
    @alert = alert

    mail(to: opts[:to], subject: opts[:subject])
  end
end
