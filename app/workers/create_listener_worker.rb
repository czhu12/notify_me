class CreateListenerWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 0, :backtrace => true

  def perform(args)
    listener = get_listener(args['listener_id'])
    AlertMailer.registered_listener(
      listener,
      {to: listener.email, subject: "Created new listener for #{listener.query}"},
    ).deliver_now
  end

  def get_listener(listener_id)
    Listener.find(listener_id)
  end
end
