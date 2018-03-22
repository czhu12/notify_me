every 1.minutes roles: [:web] do
  rake "schedule_listeners:enqueue_requests"
end
