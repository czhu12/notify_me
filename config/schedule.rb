every 1.hours, roles: [:web] do
  rake "schedule_listeners:enqueue_requests"
end
