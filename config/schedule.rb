set :output, '/home/deploy/notify_me/shared/log/whenever.log'
every 5.minutes roles: [:web] do
  rake "schedule_listeners:enqueue_requests"
end
