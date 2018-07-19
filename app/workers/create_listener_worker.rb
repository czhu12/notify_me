class CreateListenerWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 0, :backtrace => true

  def perform(args)
    listener = get_listener(args['listener_id'])
    if listener.email
      AlertMailer.registered_listener(
        listener,
        {to: listener.email, subject: "Created new listener for #{listener.query}"},
      ).deliver_now
    end

    if listener.phone_number
      text_client = Plivo::RestClient.new(
        Rails.application.secrets[:plivo_auth_id],
        Rails.application.secrets[:plivo_auth_token],
      )
      text_client.messages.create(
        Rails.application.secrets[:plivo_phone_number],
        [listener.phone_number],
        "Created new listener for #{listener.query} #{listener.permalink}",
      )
    end
  end

  def get_listener(listener_id)
    Listener.find(listener_id)
  end
end
