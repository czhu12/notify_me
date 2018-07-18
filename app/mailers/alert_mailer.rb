class AlertMailer < ActionMailer::Base
  include SendGrid
  add_template_helper(ListenersHelper)
  default from: "no-reply@utiquelearn.com"
  layout 'mailer'

  def send_alert(alert, opts)
    @alert = alert

    mail(to: opts[:to], subject: opts[:subject])
  end

  def registered_listener(listener, opts)
    return unless listener.email
    @listener = listener

    mail(to: listener.email, subject: opts[:subject])
  end
end
