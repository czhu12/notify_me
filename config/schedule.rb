env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

set :output, '/home/deploy/notify_me/shared/log/whenever.log'
every 30.minutes roles: [:web] do
  rake "schedule_listeners:enqueue_requests"
end
