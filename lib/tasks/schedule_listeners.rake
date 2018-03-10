# bundle exec rake schedule_listeners:enqueue_requests
namespace :schedule_listeners do
  desc "Run `bundle exec rake schedule_listeners:enqueue_requests` to schedule new jobs"
  task enqueue_requests: :environment do
    SocialWatcher.all.each do |social_watcher|
      puts """
      Scheduled Request
        query: `#{social_watcher.listener.query}`
        source: `#{SocialWatcher::SOURCE_NAMES[social_watcher.source]}`
        metadata: #{social_watcher.metadata}
      """

      FetchContentWorker.perform_async(
        {
          social_watcher_id: social_watcher.id,
          rate_limit_key: social_watcher.rate_limit_key,
          rate_limit_time: social_watcher.rate_limit_time,
        }
      )
    end
  end
end
