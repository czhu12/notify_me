module RateLimitHelper
  def rate_limited(rate_limit_key, rate_limit_time)
    # Loop until its free
    while REDIS.get(rate_limit_key)
      sleep(rate_limit_time)
    end

    # We probably need some atomic read write thing here
    REDIS.multi do |multi|
      REDIS.set(rate_limit_key, 1)
      REDIS.expire(rate_limit_key, rate_limit_time)
    end

    yield
  end
end
