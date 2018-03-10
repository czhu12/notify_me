class Notifier
  attr_accessor :phone_number, :email, :preferences, :alert

  def initialize(phone_number, email, preferences, alert)
    @phone_number = phone_number
    @email = email
    @preferences = preferences
    @alert
  end

  def notify
    # Send email
    if preferences[:email]
      send_email
    end

    if preferences[:text_message]
      send_text_message
    end
  end

  def send_email
    Rails.logger.info("Sent email to #{email}")
  end

  def send_text_message
    Rails.logger.info("Sent text message to #{phone_number}")
  end
end
