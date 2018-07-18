class Notifier
  attr_accessor :phone_number, :email, :preferences, :alert

  def initialize(phone_number, email, preferences, alert)
    phone_number = "1#{phone_number}" if phone_number.size <= 10
    @phone_number = phone_number
    @email = email
    @preferences = preferences
    @alert = alert
    @text_client = Plivo::RestClient.new(
      Rails.application.secrets[:plivo_auth_id],
      Rails.application.secrets[:plivo_auth_token],
    )
  end

  def notify
    # Send email
    send_email if preferences[:email]
    send_text_message if preferences[:phone]
  end

  def send_email
    AlertMailer.send_alert(
      alert,
      {to: email, subject: email_subject(alert)},
    ).deliver_now
    Rails.logger.info("Sent email to #{email}")
  end

  def send_text_message
    @text_client.messages.create(
      Rails.application.secrets[:plivo_phone_number],
      [phone_number],
      text_message(alert),
    )
    Rails.logger.info("Sent text message to #{phone_number}")
  end

  def email_subject(alert)
    query = alert.social_watcher.listener.query
    username = alert.username
    permalink = alert.permalink
    "#{username} mentioned `#{query}` in #{alert.social_watcher.source_name}"
  end

  def text_message(alert)
    query = alert.social_watcher.listener.query
    username = alert.username
    permalink = alert.permalink
    "#{username} mentioned `#{query}` in #{permalink}"
  end
end
