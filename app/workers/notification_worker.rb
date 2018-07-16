class NotificationWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 0, :backtrace => true

  def perform(args)
    alert = get_alert(args['alert_id'])
    listener = alert.social_watcher.listener
    Notifier.new(
      listener.phone_number,
      listener.email,
      {:email => true, :phone => true},
      alert,
    ).notify
  end

  def get_alert(alert_id)
    Alert.find(alert_id)
  end
end
