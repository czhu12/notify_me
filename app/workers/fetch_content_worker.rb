class FetchContentWorker
  include Sidekiq::Worker
  include RateLimitHelper

  def perform(args)
    watcher = get_watcher(args[:social_watcher_id])

    rate_limit_key = args[:rate_limit_key]
    rate_limit_time = args[:rate_limit_time]

    rate_limited(rate_limit_key, rate_limit_time) do
      results = watcher.fetch_data
      results.each do |data|
        # Check if data.id has already been alerted on.
        next if Alert.exists?(data_id: data.id)
        if watcher.listener.matches_query?(data.text)
          alert = watcher.create_alert(data)
        end
      end
    end
  end

  def get_watcher(args)
    SocialWatcher.find(args[:social_watcher_id])
  end
end
