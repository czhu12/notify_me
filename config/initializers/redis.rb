if Rails.env.production?
  REDIS = Redis.new(host: "redis", port: 6379, db: 0)
elsif Rails.env.development?
  REDIS = Redis.new(host: "127.0.0.1", port: 6379, db: 0)
else
  REDIS = MockRedis.new
end
